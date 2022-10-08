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
}

enum RequestError: Error {
    case requestFailed(statusCode: Int)
}
