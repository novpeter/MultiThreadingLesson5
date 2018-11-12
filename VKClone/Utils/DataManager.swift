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
    var delay: Double = 2
    
    private init() {
        posts = Generator().generateRandomPosts()
        currentUser = Generator().getRandomUser()
    }
    
    /// Returns current posts
    ///
    /// - Parameter completionBlock: block for returning posts
    func obtainData(completionBlock: @escaping ([Post]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
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
    
    /// Search post by given id
    ///
    /// - Parameter id: identificator
    /// - Returns: post with given id
    func searchPost(by id: String) -> Post? {
        let result = posts.filter{ post in post.id == id }
        
        if result.count != 0 {
            return result.first
        }
        
        return nil
    }
    
    /// Async version of searching post by given id
    ///
    /// - Parameter id: identificator
    ///   - completionBlock: for returning post with given id
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
    
    /// Add new post
    ///
    /// - Parameter post: new post
    func addPost(_ post: Post) {
        
        var newPosts: [Post] = [post]
        newPosts += posts
        posts = newPosts
    }
    
    /// Async version of adding new post at top
    /// - Parameters:
    ///   - post: new post
    func asyncAddPost(_ post: Post, completionBlock: @escaping (Bool) -> Void) {
        
        addOperationQueue.addOperation {
            
            self.addPost(post)
            completionBlock(true)
        }
    }
    
    
    // MARK: - Save post
    
    /// Save updated post
    ///
    /// - Parameter post: post with changes
    func saveAndUpdatePost(_ post: Post) {
        
        let index = posts.firstIndex { (oldPost) -> Bool in
            oldPost.id == post.id
        }
        
        if index == -1 {
            posts.insert(post, at: posts.count)
        }
        else {
            posts.remove(at: index!)
            posts.insert(post, at: index!)
        }
        
    }
    
    /// Async version of saving of updated post
    ///
    /// - Parameters:
    ///   - post: post with changes
    ///   - completionBlock: for returing result of operations
    func asyncSaveAndUpdatePost(_ post: Post, completionBlock: @escaping (Bool) -> Void) {
        
        saveOperationQueue.addOperation {
            
            self.saveAndUpdatePost(post)
            completionBlock(true)
        }
    }
    
}
