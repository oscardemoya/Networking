//
//  Request.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

public struct Request<Response> {
    var method: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]?
    var body: String?
    var headers: [String: String]?
    
    public init(method: HTTPMethod, path: String, queryItems: [URLQueryItem]?, body: String? = nil,
         headers: [String : String]? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.body = body
        self.headers = headers
    }
}

enum RequestError: Error {
    case requestFailed(statusCode: Int)
}
