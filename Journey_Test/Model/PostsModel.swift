//
//  PostsModel.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

// MARK: - WelcomeElement
struct PostsModel: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

