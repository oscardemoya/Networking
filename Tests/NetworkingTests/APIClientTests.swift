//
//  APIClientTests.swift
//  
//
//  Created by Oscar De Moya on 9/10/22.
//

import XCTest
@testable import Networking

final class APIClientTests: XCTestCase {
    
    func testAPIClient_init_withBaseURL() async {
        let client = APIClient(baseURL: "http://example.com")
        let baseURL = await client.api.baseURL
        XCTAssertEqual(baseURL, "http://example.com")
    }
    
    func testAPIClient_get_shouldSendGETHTTPMethod() async throws {
    }
    
}
