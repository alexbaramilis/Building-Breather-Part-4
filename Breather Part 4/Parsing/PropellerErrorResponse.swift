//
//  PropellerErrorResponse.swift
//  Breather
//
//  Created by Alexandros Baramilis on 10/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/// The Decodable-conformant representation of Air by Propeller API's error response.
struct PropellerErrorResponse: Decodable {
    let message: String?
    let description: String?
}

// MARK: - RxMoya extension

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    /// If the Response status code is in the 200 - 299 range, it lets the Response through.
    /// If it's outside that range, it tries to map the Response into a PropellerErrorResponse
    /// object and throws a PropellerError with the appropriate message from PropellerErrorResponse.
    func catchPropellerError(_ type: PropellerErrorResponse.Type) -> Single<ElementType> {
        return flatMap { response in
            if (200...299).contains(response.statusCode) {
                return .just(response)
            } else {
                do {
                    let propellerErrorResponse = try response.map(type.self)
                    throw PropellerError(message: propellerErrorResponse.message ?? propellerErrorResponse.description ?? "")
                } catch {
                    throw error
                }
            }
        }
    }
}

// MARK: - PropellerError

/// A type representing Air by Propeller API error messages.
enum PropellerError: Error {
    case unknown
    case with(message: String)

    init(message: String) {
        switch message {
        default: self = message.isEmpty ? .unknown : .with(message: message)
        }
    }
}

extension PropellerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("Air by Propeller API: An unknown error occurred.", comment: "")
        case .with(let message): return NSLocalizedString("Air by Propeller API: An error occurred with message: \"\(message)\"", comment: "")
        }
    }
}
