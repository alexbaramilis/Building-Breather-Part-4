//
//  CityConditions.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

/// The CityConditions model.
struct CityConditions {
    let city: String
    let weather: Weather
    let pollution: Pollution
    let asthma: Asthma
}

/// The Weather model.
struct Weather {
    let timestamp: String // timestamp: ex. "2018-12-04T18:00:00.000Z" (ISO 8601) (Z stands for UTC)
    let iconCode: String // weather icon code: ex. "10n"
    let temperature: Int // temperature: ex. 6 (Celsius)
    let humidity: Int // humidity: 93 (%)
    let pressure: Int // atmospheric pressure: ex. 1022 (hPa)
    let windSpeed: Float // wind speed: ex. 2.26 (m/s)
    let windDirection: Int // wind direction as an angle of 360° (N=0, E=90, S=180, W=270): ex. 145
}

// The Pollution model.
struct Pollution {
    let timestamp: String // timestamp: ex. "2018-12-04T18:00:00.000Z" (ISO 8601) (Z stands for UTC)
    let aqiUS: Int // AQI value based on US EPA standard: ex. 4
    let mainPollutantUS: String // main pollutant for US AQI: ex. "o3"
    let aqiChina: Int // AQI value based on China MEP standard: ex. 3
    let mainPollutantChina: String // main pollutant for Chinese AQI: ex. "o3"
}

// The Asthma model.
struct Asthma {
    let risk: String // risk of adverse respiratory conditions: "high", "medium" or "low"
    let probability: Double // probability of adverse respiratory conditions: ex. 0.4938...
}

extension CityConditions {
    static func sampleData() -> CityConditions {
        let weather = Weather(timestamp: "2019-04-16T11:00:00.000Z",
                              iconCode: "01d",
                              temperature: 5,
                              humidity: 36,
                              pressure: 1015,
                              windSpeed: 9.8,
                              windDirection: 300)
        let pollution = Pollution(timestamp: "2019-04-16T08:00:00.000Z",
                                  aqiUS: 9,
                                  mainPollutantUS: "p2",
                                  aqiChina: 3,
                                  mainPollutantChina: "p2")
        let asthma = Asthma(risk: "medium",
                            probability: 0.63)
        return CityConditions(city: "New York",
                              weather: weather,
                              pollution: pollution,
                              asthma: asthma)
    }
}
