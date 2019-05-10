//
//  BreatherError.swift
//  Breather
//
//  Created by Alexandros Baramilis on 02/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

enum BreatherError: Error {
    case unknown
}

extension BreatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("An unknown error occurred.", comment: "")
        }
    }
}
