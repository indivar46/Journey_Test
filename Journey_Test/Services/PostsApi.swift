//
//  PostsApi.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

struct PostsApi: APIHandler {
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().posts
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [PostsModel] {
        return try defaultParseResponse(data: data,response: response)
    }
    
}
