//
//  MockNetworkError.swift
//  GOKTests
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation
@testable import GOK

enum MockNetworkError: Error, LocalizedError {
    case mock

    public var errorDescription: String? {
        switch self {
        case .mock: return "mock"
        }
    }
}
