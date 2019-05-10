//
//  PropellerForecastResponse.swift
//  Breather
//
//  Created by Alexandros Baramilis on 07/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

/// The Decodable-conformant representation of Air by Propeller API's forecast endpoint response.
struct PropellerForecastResponse: Decodable {
    let properties: PropellerForecastProperties
}

/// The Decodable-conformant representation of the properties property of PropellerForecastResponse.
struct PropellerForecastProperties: Decodable {
    let risk: String // risk of adverse respiratory conditions: "high", "medium" or "low"
    let probability: Double // probability of adverse respiratory conditions: ex. 0.4938...
}

// MARK: - CodingKeys

extension PropellerForecastProperties {
    enum CodingKeys: String, CodingKey {
        case risk = "code"
        case probability = "value"
    }
}

// MARK: - Helper methods

extension PropellerForecastResponse {
    /// Extracts an Asthma model from PropellerForecastResponse.
    func getAsthma() -> Asthma {
        return Asthma(risk: self.properties.risk,
                      probability: self.properties.probability)
    }
}
