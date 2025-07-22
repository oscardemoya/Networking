//
//  NetworkMonitor.swift
//  Networking
//
//  Created by Oscar De Moya on 2/4/25.
//

import Network
import Combine

public class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published public var isConnected: Bool = true
    
    public init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
