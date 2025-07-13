//
//  Data+JSON.swift
//  Networking
//
//  Created by Oscar De Moya on 2025/7/13.
//

import Foundation

public extension Data {
    var jsonPrettyPrinted: String? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var jsonObject: [String: Any] {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any] else {
            return [:]
        }
        return json
    }
}
