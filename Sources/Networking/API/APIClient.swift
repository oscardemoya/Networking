//
//  APIClient.swift
//  Networking
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

protocol Client {
    func send<Response: Decodable>(request: Request<Response>) async throws -> Response
}

public actor APIClient: Client {
    typealias Response = Decodable
    private let api: any API
    private let session: URLSession
    private let delegate: URLSessionTaskDelegate?
    
    public init(api: any API, session: URLSessionConfiguration = .default, delegate: URLSessionTaskDelegate? = nil) {
        self.api = api
        self.session = URLSession(configuration: session)
        self.delegate = delegate
    }
    
    public func send<Response: Decodable>(request: Request<Response>) async throws -> Response {
        let urlRequest = URLRequest(api: api, request: request)
        let (data, response) = try await session.data(for: urlRequest, delegate: delegate)
        if let string = String(data: data, encoding: .utf8) {
            print(urlRequest.url?.absoluteString ?? "")
            print(string)
        }
        try validate(response: response, data: data)
        return try await decode(data)
    }
    
    func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        guard (200..<300) ~= httpResponse.statusCode else {
            throw ResponseError.unacceptable(statusCode: httpResponse.statusCode)
        }
    }
    
    func decode<T: Decodable>(_ data: Data) async throws -> T {
        if T.self == String.self {
            guard let string = String(data: data, encoding: .utf8), let value = string as? T else {
                throw URLError(.badServerResponse)
            }
            return value
        }
        return try await Task.detached {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }.value
    }
}
