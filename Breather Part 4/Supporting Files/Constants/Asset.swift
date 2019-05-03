//
//  Asset
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

enum Asset {
    /// Returns the asset name for the weather icon corresponding to the icon code.
    ///
    /// Some icon codes have the same weather icon representing them.
    static func forIconCode(_ iconCode: String) -> String {
        switch iconCode {
        case "01d": return "01d.png" // clear sky (day)
        case "01n": return "01n.png" // clear sky (night)
        case "02d": return "02d.png" // few clouds (day)
        case "02n": return "02n.png" // few clouds (night)
        case "03d": return "03d.png" // scattered clouds (day)
        case "03n": return "03d.png" // same icon for night
        case "04d": return "04d.png" // broken clouds (day)
        case "04n": return "04d.png" // same icon for night
        case "09d": return "09d.png" // shower rain (day)
        case "09n": return "09d.png" // same icon for night
        case "10d": return "10d.png" // rain (day)
        case "10n": return "10n.png" // rain (night)
        case "11d": return "11d.png" // thunderstorm (day)
        case "11n": return "11d.png" // same icon for night
        case "13d": return "13d.png" // snow (day)
        case "13n": return "13d.png" // same icon for night
        case "50d": return "50d.png" // mist (day)
        case "50n": return "50d.png" // same icon for night
        default: return "" // better UX to set a placeholder image
        }
    }
}
