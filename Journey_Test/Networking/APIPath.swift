//
//  APIPath.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation


#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var posts: String { return "\(baseURL)/posts"}
    var comments: String { return "\(baseURL)/comments"}
}
