//
//  PostAPITests.swift
//  Journey_TestTests
//
//  Created by Indivar Raina on 07/08/22.
//

import XCTest
@testable import Journey_Test
class PostAPITests: XCTestCase {


    func test_api_for_request() {
        let api = PostsApi()
        let params = [:] as [String : Any];
        let request = api.makeRequest(from: params)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "jsonplaceholder.typicode.com")
    }
    
    func test_api_for_parsing_logic() {
        let api = PostsApi()
        let data = [PostsModel(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),PostsModel(userID: 1, id: 2, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(data),
           let url = URL(string: APIPath().posts),
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.count, 2)
        }
        
    }
    
}
