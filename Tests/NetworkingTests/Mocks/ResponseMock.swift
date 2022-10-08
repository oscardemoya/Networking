//
//  ResponseMock.swift
//  
//
//  Created by Oscar De Moya on 8/10/22.
//

@testable import Networking

struct ResponseMock: Decodable {
}

struct Post: Decodable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
