//
//  AirVisualErrorResponse.swift
//  Breather
//
//  Created by Alexandros Baramilis on 10/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/// The Decodable-conformant representation of AirVisual API's error response.
struct AirVisualErrorResponse: Decodable {
    let status: String
    let data: AirVisualErrorData
}

/// The Decodable-conformant representation of the data property of AirVisualErrorResponse.
struct AirVisualErrorData: Decodable {
    let message: String
}

// MARK: - RxMoya extension

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    /// If the Response status code is in the 200 - 299 range, it lets the Response through.
    /// If it's outside that range, it tries to map the Response into an AirVisualErrorResponse
    /// object and throws an AirVisualError with the appropriate message from AirVisualErrorResponse.
    func catchAirVisualError(_ type: AirVisualErrorResponse.Type) -> Single<ElementType> {
        return flatMap { response in
            guard (200...299).contains(response.statusCode) else {
                do {
                    let airVisualErrorResponse = try response.map(type.self)
                    throw AirVisualError(message: airVisualErrorResponse.data.message)
                } catch {
                    throw error
                }
            }
            return .just(response)
        }
    }
}

// MARK: - AirVisualError

/// A type representing AirVisual API error messages.
/// The list is not exhaustive and not all cases are required in this app.
enum AirVisualError: Error {
    case callLimitReached
    case apiKeyExpired
    case incorrectAPIKey
    case ipLocationFailed
    case noNearestStation
    case featureNotAvailable
    case tooManyRequests
    case wrongCoordinates
    case noNearestCity
    case callPerMinuteLimitReached
    case unknown
    case with(message: String)

    init(message: String) {
        switch message {
        case "call_limit_reached": self = .callLimitReached
        case "api_key_expired": self = .apiKeyExpired
        case "incorrect_api_key": self = .incorrectAPIKey
        case "ip_location_failed": self = .ipLocationFailed
        case "no_nearest_station": self = .noNearestStation
        case "feature_not_available": self = .featureNotAvailable
        case "too_many_requests": self = .tooManyRequests
        case "wrong_coordinates": self = .wrongCoordinates
        case "no_nearest_city": self = .noNearestCity
        case "call_per_minute_limit_reached": self = .callPerMinuteLimitReached
        default: self = message.isEmpty ? .unknown : .with(message: message)
        }
    }
}

extension AirVisualError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .callLimitReached: return NSLocalizedString("AirVisual API: Minute/monthly request limit has been reached. Please try again later.", comment: "")
        case .apiKeyExpired: return NSLocalizedString("AirVisual API: The API key has expired. Please contact the developer.", comment: "")
        case .incorrectAPIKey: return NSLocalizedString("AirVisual API: The API key is wrong. Please contact the developer.", comment: "")
        case .ipLocationFailed: return NSLocalizedString("AirVisual API: Unable to locate your IP address.", comment: "")
        case .noNearestStation: return NSLocalizedString("AirVisual API: There is no nearest station within your radius.", comment: "")
        case .featureNotAvailable: return NSLocalizedString("AirVisual API: This feature is not available with your subscription plan.", comment: "")
        case .tooManyRequests: return NSLocalizedString("AirVisual API: Too many requests, please try again later.", comment: "")
        case .wrongCoordinates: return NSLocalizedString("AirVisual API: The coordinates specified are wrong.", comment: "")
        case .noNearestCity: return NSLocalizedString("AirVisual API: No nearest city has been found.", comment: "")
        case .callPerMinuteLimitReached: return NSLocalizedString("AirVisual API: Calls per minute have been reached. Please try again later.", comment: "")
        case .unknown: return NSLocalizedString("AirVisual API: An unknown error occurred.", comment: "")
        case .with(let message): return NSLocalizedString("AirVisual API: An error occurred with message: \"\(message)\"", comment: "")
        }
    }
}
