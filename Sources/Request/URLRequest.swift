//
//  URLRequest.swift
//  
//
//  Created by Oscar De Moya on 8/10/22.
//

import Foundation

public extension URLRequest {
    init<T: Decodable>(api: any API, request: Request<Response<T>>) {
        let url = api.url(appending: request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.verb
        if let queryItems = request.queryItems {
            urlRequest.url?.append(queryItems: queryItems)
        }
        if let body = request.body {
            urlRequest.httpBody = body
        }
        request.headers?.forEach { (header, value) in
            urlRequest.setValue(value, forHTTPHeaderField: header)
        }
        if urlRequest.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue) == nil {
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        self = urlRequest
    }
}
