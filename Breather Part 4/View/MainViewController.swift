//
//  MainViewController.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    // MARK: - Dependencies

    var viewModel: MainViewModel!

    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!

    // Views for binding
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var mainPollutantLabel: UILabel!
    @IBOutlet weak var aqiStandardSegmentedControl: UISegmentedControl!
    @IBOutlet weak var asthmaRiskLabel: UILabel!
    @IBOutlet weak var asthmaProbabilityLabel: UILabel!

    // Constraints
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!

    // MARK: - Private Properties

    private let refreshSubject = PublishSubject<Void>()
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        bindViewModel()
        setupRefreshControl()
    }

    @objc private func didBecomeActive() {
        refresh()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentViewHeight.constant = view.bounds.height > 504 ? view.bounds.height : 504
    }

    // MARK: - Methods

    private func bindViewModel() {
        // Inputs
        refreshSubject
            .subscribe(viewModel.input.viewDidRefresh)
            .disposed(by: disposeBag)
        aqiStandardSegmentedControl.rx.selectedSegmentIndex
            .subscribe(viewModel.input.aqiStandard)
            .disposed(by: disposeBag)
        // Outputs
        // - Data
        viewModel.output.city.drive(cityLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.weatherImage.drive(weatherImageView.rx.image).disposed(by: disposeBag)
        viewModel.output.temperature.drive(temperatureLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.temperatureColour.drive(onNext: { [unowned self] color in
            self.temperatureLabel.textColor = color
        }).disposed(by: disposeBag)
        viewModel.output.humidity.drive(humidityLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.pressure.drive(pressureLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.windSpeed.drive(windLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.windDirection.drive(onNext: { [unowned self] direction in
            self.windDirectionImageView.transform = CGAffineTransform(rotationAngle: direction)
        }).disposed(by: disposeBag)
        viewModel.output.airQuality.drive(airQualityLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.airQualityColour.drive(onNext: { [unowned self] color in
            self.airQualityLabel.textColor = color
        }).disposed(by: disposeBag)
        viewModel.output.aqi.drive(aqiLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.mainPollutant.drive(onNext: { [unowned self] text in
            self.mainPollutantLabel.setAttributedTextWithSubscripts(
                text: text,
                indicesOfSubscripts: text.indicesOfNumbers)
        }).disposed(by: disposeBag)
        viewModel.output.asthmaRisk.drive(asthmaRiskLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.asthmaRiskColour.drive(onNext: { [unowned self] color in
            self.asthmaRiskLabel.textColor = color
        }).disposed(by: disposeBag)
        viewModel.output.asthmaProbability.drive(asthmaProbabilityLabel.rx.text).disposed(by: disposeBag)
        // - Loading
        viewModel.output.isLoading.drive(onNext: { [unowned self] isLoading in
            self.showLoadingIndicators(isLoading)
        }).disposed(by: disposeBag)
        // - Error
        viewModel.output.error.drive(onNext: { [unowned self] error in
            self.showAlert(title: "Error", message: error.localizedDescription.capitalizedFirstLetter)
        }).disposed(by: disposeBag)
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }

    @objc private func refresh() {
        refreshSubject.onNext(())
    }

    private func showLoadingIndicators(_ isLoading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        if !isLoading {
            refreshControl.endRefreshing()
        }
    }
}
