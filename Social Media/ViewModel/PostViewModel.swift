//
//  PostViewModel.swift
//  Social Media
//
//  Created by Sarthak Deshmukh on 29/10/25.
//
import SwiftUI
import Foundation

class PostViewModel: ObservableObject {
    
    
    func savePost(id: Int16,selectedImage: UIImage?, comment: String?, isLike: Bool, description: String, location: String) {
        let post = PostEntity(context: CoreDataManager.shared.context)
      
        guard let image = selectedImage,
                   let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        post.id = id
        post.image = imageData
        post.comment = comment
        post.isLike = isLike
        post.location = location
        post.imageDescription = description
        
        CoreDataManager.shared.saveData()
    }
}
