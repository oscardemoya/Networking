//
//  ResponseMock.swift
//  NetworkingTests
//
//  Created by Oscar De Moya on 8/10/22.
//

@testable import Networking

struct ResponseMock: Decodable {
}

struct EntityMock: Decodable {
    var id: Int
    var title: String
    var body: String
}
