//
//  EnvironmentURLTests.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 7/10/22.
//

import Testing
@testable import Networking

@Test func testRouter_productionBaseURL() async {
    let router = APIMock.stub(environment: .production)
    #expect(router.baseURL == "https://example.com")
}

@Test func testRouter_developmentBaseURL() throws {
    let router = APIMock.stub(environment: .development)
    #expect(router.baseURL == "https://dev.example.com")
}
