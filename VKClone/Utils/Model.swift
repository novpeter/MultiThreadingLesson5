//
//  Model.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

/// - Parameters:
///   - groupName: group title
//    - groupAvatar: group avatar
//    - postDate: date of news posting
//    - postText: news text
//    - postImageLink: attached image
//    - likesCount: how many likes
//    - commentsCount: how many comments
//    - viewsCount: how many watchers
struct Model {
    var id: String
    var groupName: String
    var groupAvatar: String
    var postDate: String
    var postText: String
    var postImageLink: String
    var likesCount: Int
    var commentsCount: Int
    var viewsCount: Int
}
