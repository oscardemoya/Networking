//
//  APIClientTests.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 9/10/22.
//

import Testing
@testable import Networking

@Test func testAPIClient_init_withBaseURL() async {
    let client = APIClient(baseURL: "http://example.com")
    let baseURL = await client.api.baseURL
    #expect(baseURL == "http://example.com")
}
