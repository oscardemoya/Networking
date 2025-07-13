//
//  Bundle.swift
//  Networking
//
//  Created by Oscar De Moya on 2025/7/13.
//

import Foundation

public extension Bundle {
    static var identifier: String {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            fatalError("Unable retrieve the bundle identifier")
        }
        return bundleIdentifier
    }
}
