//
//  AirVisualAPI.swift
//  Breather
//
//  Created by Alexandros Baramilis on 30/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import Moya

/// Moya representation of the AirVisual API.
enum AirVisualAPI {
    static private let key = "A5xEAXuhEFJZyZA4o"

    case nearestCity(lat: Double, lon: Double)
}

extension AirVisualAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.airvisual.com/v2")!
    }

    var path: String {
        switch self {
        case .nearestCity: return "/nearest_city"
        }
    }

    var method: Moya.Method {
        switch self {
        case .nearestCity: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .nearestCity(lat, lon):
            let parameters = [
                "lat": String(lat),
                "lon": String(lon),
                "key": AirVisualAPI.key
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
