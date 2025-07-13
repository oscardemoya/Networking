//
//  APITests.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 7/10/22.
//

import Testing
import Foundation
@testable import Networking

@Test func testRouter_url_whenAppendingAPath_shouldReturnTheFullURL() throws {
    // given
    let api = APIMock.stub()
    let path = "/test"
    
    // when
    let url = api.url(appending: path)
    
    // then
    #expect(url.absoluteString == "https://example.com/test")
}

@Test func testAPI_request_withEndpoint_shouldAppendPathAndQueryItems() throws {
    // given
    let api = APIMock.stub()
    let path = "/search/posts"
    let queryItems = [URLQueryItem(name: "q", value: "test")]
    let request = Request<Response<ResponseMock>>.stub(path: path, queryItems: queryItems)
    
    // when
    let urlRequest = URLRequest(api: api, request: request)
    
    // then
    #expect(urlRequest.url?.absoluteString == "https://example.com/search/posts?q=test")
}
