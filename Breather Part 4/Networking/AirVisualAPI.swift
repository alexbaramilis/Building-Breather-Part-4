//
//  AirVisual.swift
//  Breather
//
//  Created by Alexandros Baramilis on 30/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import Moya

public enum AirVisualAPI {
    static private let key = "A5xEAXuhEFJZyZA4o"
    // Endpoints
    case nearestCity(lat: Double, lon: Double)
}

extension AirVisualAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.airvisual.com/v2")!
    }

    public var path: String {
        switch self {
        case .nearestCity: return "/nearest_city"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .nearestCity: return .get
        }
    }

    public var sampleData: Data {
        return Data() // We can also provide mock data here for unit tests
    }

    public var task: Task {
        switch self {
        case .nearestCity(let lat, let lon):
            let parameters = [
                "lat": String(lat),
                "lon": String(lon),
                "key": AirVisualAPI.key
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
        return .none
    }
}
