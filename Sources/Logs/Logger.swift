//
//  Logger.swift
//  Networking
//
//  Created by Oscar De Moya on 2025/7/8.
//

import OSLog

let logger = {
    Config.isLoggingEnabled ? Logger(subsystem: Bundle.identifier, category: "networking") : Logger(.disabled)
}()
