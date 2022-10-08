//
//  EnvironmentURLTests.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import XCTest
@testable import Networking

final class EnvironmentURLTests: XCTestCase {
    
    func testRouter_productionBaseURL() throws {
        let router = APIMock.stub(environment: .production)
        XCTAssertEqual(router.baseURL, "https://example.com")
    }
    
    func testRouter_developmentBaseURL() throws {
        let router = APIMock.stub(environment: .development)
        XCTAssertEqual(router.baseURL, "https://dev.example.com")
    }
    
}
