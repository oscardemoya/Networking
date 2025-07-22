//
//  APIClient.swift
//  
//
//  Created by Oscar De Moya on 9/10/22.
//

import Foundation

/// Syntax Sugar for most common HTTP methods

public extension APIClient {
    
    /// Sends a GET HTTP request
    func get<T: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, body: Data? = nil,
                           headers: [String: String]? = nil) async throws -> Response<T> {
        return try await request(method: .get, path: path, queryItems: queryItems, body: body, headers: headers)
    }
    
    /// Sends a POST HTTP request
    func post<T: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, body: Data? = nil,
                            headers: [String: String]? = nil) async throws -> Response<T> {
        return try await request(method: .post, path: path, queryItems: queryItems, body: body, headers: headers)
    }
    
    /// Sends a PUT HTTP request
    func put<T: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, body: Data? = nil,
                           headers: [String: String]? = nil) async throws -> Response<T> {
        return try await request(method: .put, path: path, queryItems: queryItems, body: body, headers: headers)
    }
    
    /// Sends a DELETE HTTP request
    func delete<T: Decodable>(_ path: String, queryItems: [URLQueryItem]? = nil, body: Data? = nil,
                              headers: [String: String]? = nil) async throws -> Response<T> {
        return try await request(method: .delete, path: path, queryItems: queryItems, body: body, headers: headers)
    }
    
    /// Sends a HTTP request with a given HTTP method
    private func request<T: Decodable>(method: HTTPMethod,
                                       path: String, queryItems: [URLQueryItem]? = nil, body: Data? = nil,
                                       headers: [String: String]? = nil) async throws -> Response<T> {
        let request = Request<Response<T>>(method: method, path: path, queryItems: queryItems, body: body,
                                           headers: headers)
        return try await send(request: request)
    }
}
