//
//  API.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

public protocol API {
    var baseURL: URL { get }
}

public extension API {
    func url(appending path: String) -> URL {
        baseURL.appending(path: path)
    }    
}

struct DefaultAPI: API {
    var baseURL: URL
}

public enum ResponseError: Error {
    case invalidResponse
    case unacceptable(statusCode: Int)
    case dataEncodingError
    case decodingError
}
