//
//  URLRequest+Log.swift
//  Networking
//
//  Created by Oscar De Moya on 2025/7/7.
//

import Foundation

extension URLRequest {
    func log() {
        let requestDescription = restfulDescription
        logger.info("Request \(requestDescription)")
        if let allHTTPHeaderFields {
            logger.debug("Headers \(requestDescription):")
            allHTTPHeaderFields.sorted { (lhs, rhs) -> Bool in
                lhs.key.caseInsensitiveCompare(rhs.key) == .orderedAscending
            }.forEach { (key, value) in
                logger.debug("> \(key): \(value)")
            }
        }
        if let httpBody {
            if value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue) ?? "" == "application/json" {
                logJSONEncodedBody(httpBody)
            } else {
                logURLEncodedBody(httpBody)
            }
        }
    }
    
    var restfulDescription: String {
        guard let url, let httpMethod else { return "" }
        return "[\(httpMethod) \(url)]"
    }

    private func logJSONEncodedBody(_ body: Data) {
        guard let json = body.jsonPrettyPrinted else { return }
        logger.debug("Parameters \(restfulDescription): \(json)")
    }

    private func logURLEncodedBody(_ body: Data) {
        guard let parameters = String(data: body, encoding: .utf8)?.removingPercentEncoding else { return }
        logger.debug("Parameters \(restfulDescription): \(parameters)")
    }
}
