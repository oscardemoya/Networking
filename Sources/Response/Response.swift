//
//  File.swift
//  
//
//  Created by Oscar De Moya on 9/10/22.
//

import Foundation

public struct Response<T> {
    public let request: Request<Self>
    public let data: Data
    public let response: URLResponse
    public var statusCode: Int? { (response as? HTTPURLResponse)?.statusCode }
    public let value: T
}
