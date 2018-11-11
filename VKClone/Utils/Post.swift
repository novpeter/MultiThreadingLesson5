//
//  Post.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

// Post model
struct Post {
    
    // Uniq post identifier
    var id: String
    
    // Group title
    var groupName: String
    
    // Group avatar (picture)
    var groupAvatar: String
    
    // Date of news posting
    var postDate: String
    
    // News text
    var postText: String
    
    // Attached image
    var postImageLink: String
    
    // How many likes
    var likesCount: Int
    
    // How many comments
    var commentsCount: Int
    
    // How many watchers
    var viewsCount: Int
}
