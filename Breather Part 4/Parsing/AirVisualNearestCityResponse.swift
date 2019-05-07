//
//  AirVisualNearestCityResponse.swift
//  Breather
//
//  Created by Alexandros Baramilis on 07/05/2018.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

struct AirVisualNearestCityResponse: Decodable {
    let status: String
    let data: AirVisualNearestCityData
}

struct AirVisualNearestCityData: Decodable {
    let city: String
    let currentConditions: AirVisualCurrentConditions
}

struct AirVisualCurrentConditions: Decodable {
    let weather: AirVisualWeather
    let pollution: AirVisualPollution
}

struct AirVisualWeather: Decodable {
    let timestamp: String // timestamp: ex. "2018-12-04T18:00:00.000Z" (ISO 8601) (Z stands for UTC)
    let iconCode: String // weather icon code: ex. "10n"
    let temperature: Int // temperature: ex. 6 (Celsius)
    let humidity: Int // humidity: 93 (%)
    let pressure: Int // atmospheric pressure: ex. 1022 (hPa)
    let windSpeed: Float // wind speed: ex. 2.26 (m/s)
    let windDirection: Int // wind direction as an angle of 360° (N=0, E=90, S=180, W=270): ex. 145
}

struct AirVisualPollution: Decodable {
    let timestamp: String // timestamp: ex. "2018-12-04T18:00:00.000Z" (ISO 8601) (Z stands for UTC)
    let aqiUS: Int // AQI value based on US EPA standard: ex. 4
    let mainPollutantUS: String // main pollutant for US AQI: ex. "o3"
    let aqiChina: Int // AQI value based on China MEP standard: ex. 3
    let mainPollutantChina: String // main pollutant for Chinese AQI: ex. "o3"
}

// MARK: - CodingKeys

extension AirVisualNearestCityData {
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case currentConditions = "current"
    }
}

extension AirVisualWeather {
    enum CodingKeys: String, CodingKey {
        case timestamp = "ts"
        case iconCode = "ic"
        case temperature = "tp"
        case humidity = "hu"
        case pressure = "pr"
        case windSpeed = "ws"
        case windDirection = "wd"
    }
}

extension AirVisualPollution {
    enum CodingKeys: String, CodingKey {
        case timestamp = "ts"
        case aqiUS = "aqius"
        case mainPollutantUS = "mainus"
        case aqiChina = "aqicn"
        case mainPollutantChina = "maincn"
    }
}

// MARK: - Helper methods

extension AirVisualNearestCityResponse {
    func getCity() -> String {
        return self.data.city
    }

    func getWeather() -> Weather {
        return Weather(timestamp: self.data.currentConditions.weather.timestamp,
                       iconCode: self.data.currentConditions.weather.iconCode,
                       temperature: self.data.currentConditions.weather.temperature,
                       humidity: self.data.currentConditions.weather.humidity,
                       pressure: self.data.currentConditions.weather.pressure,
                       windSpeed: self.data.currentConditions.weather.windSpeed,
                       windDirection: self.data.currentConditions.weather.windDirection)
    }

    func getPollution() -> Pollution {
        return Pollution(timestamp: self.data.currentConditions.pollution.timestamp,
                         aqiUS: self.data.currentConditions.pollution.aqiUS,
                         mainPollutantUS: self.data.currentConditions.pollution.mainPollutantUS,
                         aqiChina: self.data.currentConditions.pollution.aqiChina,
                         mainPollutantChina: self.data.currentConditions.pollution.mainPollutantChina)
    }
}
