//
//  MainViewModel.swift
//  Breather
//
//  Created by Alexandros Baramilis on 15/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import UIKit.UIImage
import UIKit.UIColor
import RxSwift
import RxCocoa
import Moya

class MainViewModel: ViewModel {

    // MARK: - Dependencies

    let provider = MoyaProvider<AirVisualAPI>()
    let lat = 40.676906
    let lon = -73.942275

    // MARK: - Inputs

    let input: Input

    struct Input {
        let viewDidRefresh: AnyObserver<Void>
        let aqiStandard: AnyObserver<Int>
    }

    private let viewDidRefreshSubject = PublishSubject<Void>()
    private let aqiStandardSubject = BehaviorSubject<Int>(value: 0) // initial value doesn't matter here as it will be replaced by the selectedSegmentIndex when the view loads

    // MARK: - Outputs

    let output: Output

    struct Output {
        // Data
        let city: Driver<String>
        let weatherImage: Driver<UIImage?>
        let temperature: Driver<String>
        let temperatureColour: Driver<UIColor>
        let humidity: Driver<String>
        let pressure: Driver<String>
        let windSpeed: Driver<String>
        let windDirection: Driver<CGFloat>
        let airQuality: Driver<String>
        let airQualityColour: Driver<UIColor>
        let aqi: Driver<String>
        let mainPollutant: Driver<String>
        let asthmaRisk: Driver<String>
        let asthmaRiskColour: Driver<UIColor>
        let asthmaProbability: Driver<String>
        // Loading
        let isLoading: Driver<Bool>
        // Error
        let error: Driver<Error>
    }

    private let isLoadingSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<Error>()

    // MARK: - Private properties

    private let cityConditionsSubject = PublishSubject<CityConditions>()
    private let disposeBag = DisposeBag()

    // MARK: - Initialisation

    init() {
        input = Input(viewDidRefresh: viewDidRefreshSubject.asObserver(),
                      aqiStandard: aqiStandardSubject.asObserver())

        let city = cityConditionsSubject
            .map { $0.city }
            .asDriver(onErrorJustReturn: "...")
        let weatherImage = cityConditionsSubject
            .map { UIImage(named: Asset.forIconCode($0.weather.iconCode)) }
            .asDriver(onErrorJustReturn: nil)
        let temperature = cityConditionsSubject
            .map { "\($0.weather.temperature)℃" }
            .asDriver(onErrorJustReturn: "...℃")
        let temperatureColour = cityConditionsSubject
            .map { Color.forTemperature($0.weather.temperature) }
            .asDriver(onErrorJustReturn: UIColor.black)
        let humidity = cityConditionsSubject
            .map { "Humidity: \($0.weather.humidity)%" }
            .asDriver(onErrorJustReturn: "Humidity: ...%")
        let pressure = cityConditionsSubject
            .map { "Pressure: \($0.weather.pressure) hPa" }
            .asDriver(onErrorJustReturn: "Pressure: ... hPa")
        let windSpeed = cityConditionsSubject
            .map { "Wind: \($0.weather.windSpeed) m/s" }
            .asDriver(onErrorJustReturn: "Wind: ... m/s")
        let windDirection = cityConditionsSubject
            .map { CGFloat($0.weather.windDirection) * .pi / 180.0 }
            .asDriver(onErrorJustReturn: 0)
        let airQuality = Observable
            .combineLatest(cityConditionsSubject, aqiStandardSubject)
            .map { Text.forAQI($1 == 0 ? $0.pollution.aqiUS : $0.pollution.aqiChina) }
            .asDriver(onErrorJustReturn: "...")
        let airQualityColour = Observable
            .combineLatest(cityConditionsSubject, aqiStandardSubject)
            .map { Color.forAQI($1 == 0 ? $0.pollution.aqiUS : $0.pollution.aqiChina) }
            .asDriver(onErrorJustReturn: UIColor.black)
        let aqi = Observable
            .combineLatest(cityConditionsSubject, aqiStandardSubject)
            .map { "AQI: \($1 == 0 ? $0.pollution.aqiUS : $0.pollution.aqiChina)" }
            .asDriver(onErrorJustReturn: "AQI: ...")
        let mainPollutant = Observable
            .combineLatest(cityConditionsSubject, aqiStandardSubject)
            .map { "Main pollutant: \(Text.forMainPollutant($1 == 0 ? $0.pollution.mainPollutantUS : $0.pollution.mainPollutantChina))" }
            .asDriver(onErrorJustReturn: "Main pollutant: ...")
        let asthmaRisk = cityConditionsSubject
            .map { $0.asthma.risk.capitalized }
            .asDriver(onErrorJustReturn: "...")
        let asthmaRiskColour = cityConditionsSubject
            .map { Color.forAsthmaRisk($0.asthma.risk) }
            .asDriver(onErrorJustReturn: UIColor.black)
        let asthmaProbability = cityConditionsSubject
            .map { "Probability: \($0.asthma.probability)%" }
            .asDriver(onErrorJustReturn: "Probability: ...%")

        output = Output(city: city,
                        weatherImage: weatherImage,
                        temperature: temperature,
                        temperatureColour: temperatureColour,
                        humidity: humidity,
                        pressure: pressure,
                        windSpeed: windSpeed,
                        windDirection: windDirection,
                        airQuality: airQuality,
                        airQualityColour: airQualityColour,
                        aqi: aqi,
                        mainPollutant: mainPollutant,
                        asthmaRisk: asthmaRisk,
                        asthmaRiskColour: asthmaRiskColour,
                        asthmaProbability: asthmaProbability,
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        error: errorSubject.asDriver(onErrorJustReturn: BreatherError.unknown))

        viewDidRefreshSubject
            .do(onNext: { [unowned self] _ in
                self.isLoadingSubject.onNext(true)
            })
            .flatMap { [unowned self] _ in
                return self.provider.rx.request(.nearestCity(lat: self.lat, lon: self.lon))
                    .asObservable()
                    .materialize()
            }
            .do(onNext: { [unowned self] _ in
                self.isLoadingSubject.onNext(false)
            })
            .subscribe(onNext: { [unowned self] event in
                switch event {
                case let .next(element): print("next:", element)
                case let .error(error): self.errorSubject.onNext(error)
                case .completed: break
                }
            })
            .disposed(by: disposeBag)
    }
}
