//
//  APIHandler.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.

//

import Foundation

// MARK: APIHandler

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data:RequestDataType) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler
