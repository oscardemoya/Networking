//
//  APIMock.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 7/10/22.
//

@testable import Networking
import Foundation

// Dummy

enum AppEnvironmentMock: String {
    case development = "Development"
    case production = "Production"
}

struct APIMock: API {
    let environment: AppEnvironmentMock
    
    var baseURL: URL {
        switch environment {
        case .development: return "https://dev.example.com"
        case .production: return "https://example.com"
        }
    }
}

extension APIMock {
    static func stub(environment: AppEnvironmentMock = .production) -> Self {
        Self(environment: environment)
    }
}
