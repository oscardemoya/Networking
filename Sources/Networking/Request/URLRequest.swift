//
//  URLRequest.swift
//  
//
//  Created by Oscar De Moya on 8/10/22.
//

import Foundation

public extension URLRequest {
    init<Response: Decodable>(api: any API, request: Request<Response>) {
        let url = api.url(appending: request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.verb
        if let queryItems = request.queryItems {
            urlRequest.url?.append(queryItems: queryItems)
        }
        self = urlRequest
    }
}
