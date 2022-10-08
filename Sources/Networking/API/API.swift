//
//  API.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

public protocol API {
    associatedtype Environment
    var environment: Environment { get }
    var baseURL: URL { get }
}

public extension API {
    func url(appending path: String) -> URL {
        baseURL.appending(path: path)
    }    
}

enum ResponseError: Error {
    case unacceptable(statusCode: Int)
    case dataEncodingError
    case decodingError
}
