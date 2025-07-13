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
    let delegate: URLSessionTaskDelegate?
    
    public init(api: any API, session: URLSessionConfiguration = .default, delegate: URLSessionTaskDelegate? = nil) {
        self.api = api
        self.session = URLSession(configuration: session)
        self.delegate = delegate
    }
    
    public init(baseURL: URL, session: URLSessionConfiguration = .default, delegate: URLSessionTaskDelegate? = nil) {
        let api = DefaultAPI(baseURL: baseURL)
        self.init(api: api, session: session, delegate: delegate)
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
        let decoder = JSONDecoder()
        // TODO: Move this to a configuration (make decoder a parameter of APIClient and set those in APIClientFactory)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
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
