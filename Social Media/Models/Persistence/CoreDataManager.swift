//
//  CoreDataManager.swift
//  Social Media Feed Application
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static var shared = CoreDataManager()
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "Post")
        self.persistentContainer.loadPersistentStores { description, error in
            if error != nil {
                print("Error")
            }
        }
    }
    
    
    var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    
    func saveData() {
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func getData() -> [PostEntity]{
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        do {
            return  try context.fetch(request)
        } catch  {
            print(error.localizedDescription)
            return []
        }
    }
    
    func updatePost(id: Int16, comment: String?, newImage: UIImage?, isLike: Bool?) {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        do {
            if let post = try context.fetch(request).first {
                if let comment = comment {
                    post.comment = comment
                }
                if let newImage = newImage {
                    post.image = newImage.jpegData(compressionQuality: 0.8)
                }
                if let isLike = isLike {
                    post.isLike = isLike
                }
                
                saveData()
               
            }
        } catch {
            print("Update error: \(error.localizedDescription)")
        }
    }


       // MARK: - Delete
    func deletePost(post: PostEntity) {
        context.delete(post)
        saveData()
    }
}
