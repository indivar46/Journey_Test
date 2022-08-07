//
//  CommentsViewModel.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

struct CommentsViewModel {
    func getCommentData(param: [String: Any],postId:Int,completion: @escaping ([CommentsModel]?, ServiceError?) -> ()) {
        let request = CommentsApi()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model?.filter{ $0.postID == postId }, nil)
            }
        }
    }
}
