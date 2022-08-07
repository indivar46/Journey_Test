//
//  CommentsModel.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

struct CommentsModel: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

