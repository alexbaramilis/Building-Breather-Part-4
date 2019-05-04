//
//  PropellerAPI.swift
//  Breather
//
//  Created by Alexandros Baramilis on 04/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import Moya

enum PropellerAPI {
    case forecast(lat: Double, lon: Double)
}

extension PropellerAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://open.propellerhealth.com/prod")!
    }

    var path: String {
        switch self {
        case .forecast: return "/forecast"
        }
    }

    var method: Moya.Method {
        switch self {
        case .forecast: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .forecast(lat, lon):
            let parameters = [
                "latitude": String(lat),
                "longitude": String(lon)
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
