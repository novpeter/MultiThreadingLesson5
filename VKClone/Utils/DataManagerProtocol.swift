//
//  DataProtocol.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

// Protocol for working with data
protocol DataManagerProtocol {
    
    func searchPost(by id: String) -> Post?
    func asyncSearchPost(by id: String, completionBlock: @escaping (Post?) -> Void)
    func addPost(_ post: Post)
    func asyncAddPost(_ post: Post, completionBlock: @escaping (Bool) -> Void)
    func saveAndUpdatePost(_ post: Post)
    func asyncSaveAndUpdatePost(_ post: Post, completionBlock: @escaping (Bool) -> Void)
}
