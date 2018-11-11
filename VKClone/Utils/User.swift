//
//  User.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

// User model
struct User {
    
    // User name
    var name: String
    
    // User surname
    var surname: String
    
    // User age
    var age: Int
    
    // User status
    var status: String
    
    // Where user from
    var city: String
    
    // Status of user account
    var pageStatus: String
    
    // User main photo
    var avatar: String
    
    // Phone number
    var phone: String
    
    // Graduated from
    var school: String
    
    // User hobbies
    let hobbies: String = "Чтение книг, курение дорогих сигар, распитие эксклюзивных алкогольных напитков"
    
    // User instagram page
    let instagramLink: String = "www.instagram.com"
    
    // User facebook page
    let facebookLink: String = "www.facebook.com"
    
    // User vk page
    let vkLink: String = "www.vk.com"
}
