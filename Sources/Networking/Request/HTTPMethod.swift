//
//  HTTPMethod.swift
//  
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    case options
    case head
    case trace
    
    var verb: String { rawValue.uppercased() }
}
