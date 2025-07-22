//
//  URLQueryItem.swift
//  
//
//  Created by Oscar De Moya on 13/10/22.
//

import Foundation

extension Array<URLQueryItem>: @retroactive ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, String?)...) {
        self = elements.map { URLQueryItem(name: $0.0, value: $0.1) }
    }
}

extension Collection<URLQueryItem> {
    subscript(_ name: String) -> String? {
        first { $0.name == name }?.value
    }
}
