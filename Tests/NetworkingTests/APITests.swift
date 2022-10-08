//
//  APITests.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import XCTest
@testable import Networking

final class APITests: XCTestCase {
    
    func testRouter_url_whenAppendingAPath_shouldReturnTheFullURL() throws {
        // given
        let api = APIMock.stub()
        let path = "/test"
        
        // when
        let url = api.url(appending: path)
        
        // then
        XCTAssertEqual(url.absoluteString, "https://example.com/test")
    }

    func testAPI_request_withEndpoint_shouldAppendPathAndQueryItems() throws {
        // given
        let api = APIMock.stub()
        let path = "/search/posts"
        let queryItems = [URLQueryItem(name: "q", value: "test")]
        let request = Request<ResponseMock>.stub(path: path, queryItems: queryItems)
        
        // when
        let urlRequest = URLRequest(api: api, request: request)
        
        // then
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/search/posts?q=test")
    }

}
