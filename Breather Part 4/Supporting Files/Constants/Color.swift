//
//  Color.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import UIKit

enum Color {
    /// Returns a color corresponding to the range the given temperature is in.
    static func forTemperature(_ temperature: Int) -> UIColor {
        switch temperature {
        case Int.min...0: return UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        case 1...10: return UIColor(red: 74/255, green: 194/255, blue: 226/255, alpha: 1)
        case 11...20: return UIColor(red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
        case 21...30: return UIColor(red: 237/255, green: 222/255, blue: 41/255, alpha: 1)
        case 31...40: return UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        case 40...Int.max: return UIColor(red: 211/255, green: 76/255, blue: 92/255, alpha: 1)
        default: return UIColor.black
        }
    }

    /// Returns a color corresponding to the range the given AQI is in.
    ///
    /// The ranges and colors are the same for AQI US and AQI China.
    static func forAQI(_ aqi: Int) -> UIColor {
        switch aqi {
        case 0...50: return UIColor(red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
        case 51...100: return UIColor(red: 237/255, green: 222/255, blue: 41/255, alpha: 1)
        case 101...150: return UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        case 151...200: return UIColor(red: 211/255, green: 76/255, blue: 92/255, alpha: 1)
        case 201...300: return UIColor(red: 155/255, green: 111/255, blue: 193/255, alpha: 1)
        case 301...500: return UIColor(red: 156/255, green: 62/255, blue: 88/255, alpha: 1)
        case 501...Int.max: return UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        default: return UIColor.black
        }
    }

    /// Returns a color corresponding to the asthma risk level.
    static func forAsthmaRisk(_ risk: String) -> UIColor {
        switch risk {
        case "low": return UIColor(red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
        case "medium": return UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        case "high": return UIColor(red: 211/255, green: 76/255, blue: 92/255, alpha: 1)
        default: return UIColor.black
        }
    }
}
