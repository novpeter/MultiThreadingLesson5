//
//  DataManager.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

// Class that contains methods for working with app data
final class DataManager: DataManagerProtocol {

    static let sharedInstance = DataManager()
    
    var posts: [Post]
    var currentUser: User
    
    private init() {
        posts = Generator().generateRandomPosts()
        currentUser = Generator().getRandomUser()
    }
    
    func obtainData(completionBlock: @escaping ([Post]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionBlock(self.posts)
        }
    }
    
    // MARK: - Operation queues
    
    private lazy var searchOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Search operation queue"
        
        return queue
    }()
    
    private lazy var addOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Add operation queue"
        
        return queue
    }()
    
    private lazy var saveOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Save operation queue"
        
        return queue
    }()
    
    
    // MARK: - Search post
    
    func searchPost(by id: String) -> Post? {
        let result = posts.filter{ post in post.id == id }
        
        if result.count != 0 {
            return result.first
        }
        
        return nil
    }
    
    func asyncSearchPost(by id: String, completionBlock: @escaping (Post?) -> Void) {
        
        searchOperationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            
            let result = strongSelf.posts.filter{ post in post.id == id }
            
            if result.count == 0 {
                completionBlock(nil)
            }

            completionBlock(result.first)
        }
    }
    

    // MARK: - Add post
    
    func addPost(_ post: Post) {
        
        var newPosts: [Post] = [post]
        newPosts += posts
        posts = newPosts
    }
    
    func asyncAddPost(_ post: Post, completionBlock: @escaping (Bool) -> Void) {
        
        addOperationQueue.addOperation {
            
            self.addPost(post)
            completionBlock(true)
        }
    }
    
    
    // MARK: - Save post
    
    func saveAndUpdatePost(_ post: Post) {
        
        let index = posts.firstIndex { (oldPost) -> Bool in
            oldPost.id == post.id
        }
        posts.insert(post, at: index ?? posts.count)
    }
    
    func asyncSaveAndUpdatePost(_ post: Post, completionBlock: @escaping (Bool) -> Void) {
        
        saveOperationQueue.addOperation {
            
            self.saveAndUpdatePost(post)
            completionBlock(true)
        }
    }
    
}
