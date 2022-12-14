//
//  PostsViewModel.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

// MARK: Convert generic api response to specific model and send to controller using completion handler here

struct PostsViewModel {
    func getAPIData(param: [String: Any], completion: @escaping ([PostsModel]?, ServiceError?) -> ()) {
        let request = PostsApi()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}
