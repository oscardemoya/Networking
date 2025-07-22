//
//  APIClient.swift
//  Networking
//
//  Created by Oscar De Moya on 7/10/22.
//

import Foundation

protocol Client {
    func send<T: Decodable>(request: Request<Response<T>>) async throws -> Response<T>
}

public actor APIClient: Client {
    let api: any API
    let session: URLSession
    let decoder: JSONDecoder
    let delegate: URLSessionTaskDelegate?
    
    public init(api: any API, session: URLSessionConfiguration = .default, decoder: JSONDecoder = .init(),
                delegate: URLSessionTaskDelegate? = nil) {
        self.api = api
        self.session = URLSession(configuration: session)
        self.decoder = decoder
        self.delegate = delegate
    }
    
    public init(baseURL: URL, session: URLSessionConfiguration = .default, decoder: JSONDecoder = .init(),
                delegate: URLSessionTaskDelegate? = nil) {
        let api = DefaultAPI(baseURL: baseURL)
        self.init(api: api, session: session, decoder: decoder, delegate: delegate)
    }
    
    public func send<T: Decodable>(request: Request<Response<T>>) async throws -> Response<T> {
        let urlRequest = URLRequest(api: api, request: request)
        urlRequest.log()
        let (data, response) = try await session.data(for: urlRequest, delegate: delegate)
        response.log(data, from: urlRequest)
        try validate(data, and: response)
        let value: T = try await decode(data)
        return Response<T>(request: request, data: data, response: response, value: value)
    }
    
    func validate(_ data: Data, and response: URLResponse) throws {
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
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            if let error = error as? DecodingError {
                logger.error("Decoding Error [\(String(describing: T.self))]:")
                error.log()
                throw ResponseError.decodingError
            } else {
                logger.error("\(error)")
                throw error
            }
        }
    }
}
