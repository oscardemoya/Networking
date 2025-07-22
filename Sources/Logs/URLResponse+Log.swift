//
//  URLResponse+Log.swift
//  Networking
//
//  Created by Oscar De Moya on 2025/7/7.
//

import Foundation

extension URLResponse {
    func log(_ data: Data, from urlRequest: URLRequest) {
        guard let httpResponse = self as? HTTPURLResponse else { return }
        logger.info("Status Code \(urlRequest.restfulDescription): \(httpResponse.statusCode)")
        if let jsonResponse = data.jsonPrettyPrinted {
            logger.debug("Response \(urlRequest.restfulDescription): \(jsonResponse)")
        }
    }
}
