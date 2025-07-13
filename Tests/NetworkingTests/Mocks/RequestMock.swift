//
//  RequestMock.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 7/10/22.
//

@testable import Networking
import Foundation

extension Request {
    static func stub(method: HTTPMethod = .get, path: String = "/posts", queryItems: [URLQueryItem] = []) -> Self {
        return Self(method: method, path: path, queryItems: queryItems)
    }
}
