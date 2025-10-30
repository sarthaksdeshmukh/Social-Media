//
//  ViewModel.swift
//  Social Media
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import Foundation
import UIKit

class FeedViewModel: ObservableObject {
    
    @Published var feedList: [PostEntity] = []
    
    func getFeedList() {
        feedList = CoreDataManager.shared.getData()
     }
    
    func updatePost(id: Int16,comment: String?,image: UIImage?, isLike: Bool?) {
        CoreDataManager.shared.updatePost(id: id,comment: comment, newImage: image, isLike: isLike)
    }
}
