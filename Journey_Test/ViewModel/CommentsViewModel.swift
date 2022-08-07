//
//  CommentsViewModel.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//

import Foundation

// MARK: Convert generic api response to specific model and send to controller using completion handler here

struct CommentsViewModel {
    func getCommentData(param: [String: Any],postId:Int,completion: @escaping ([CommentsModel]?, ServiceError?) -> ()) {
        let request = CommentsApi()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                
                // MARK: Here filtering the comments as per postid type
                completion(model?.filter{ $0.postID == postId }, nil)
            }
        }
    }
}
