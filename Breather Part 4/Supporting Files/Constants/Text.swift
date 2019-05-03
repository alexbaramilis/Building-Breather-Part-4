//
//  Text.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

enum Text {
    /// Returns a string describing the conditions of the range the given AQI is in.
    ///
    /// The ranges and labels are the same for AQI US and AQI China.
    static func forAQI(_ aqi: Int) -> String {
        switch aqi {
        case 0...50: return "Good"
        case 51...100: return "Moderate"
        case 101...150: return "Unhealthy for Sensitive Groups"
        case 151...200: return "Unhealthy"
        case 201...300: return "Very Unhealthy"
        case 301...500: return "Hazardous"
        case 501...Int.max: return "F**k"
        default: return "Invalid Data"
        }
    }

    /// Returns the pollutant name corresponding to the pollutant code returned by the API.
    static func forMainPollutant(_ mainPollutant: String) -> String {
        switch mainPollutant {
        case "p2": return "PM2.5" // Particulate matter with a diameter of 2.5 μm or less
        case "p1": return "PM10" // Particulate matter with a diameter between 2.5 μm and 10 μm
        case "o3": return "O3" // Ozone
        case "n2": return "NO2" // Nitrogen dioxide
        case "s2": return "SO2" // Sulfur dioxide
        case "co": return "CO" // Carbon monoxide
        default: return "Unknown Code"
        }
    }
}
