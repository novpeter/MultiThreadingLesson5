//
//  User.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

/// - Parameters:
///   - name: user name
//    - surname: user surname
//    - age: user age
//    - status: user status
//    - city: where user from
//    - pageStatus: status of user account
//    - avatar: user avatar
//    - phone: user phone
//    - school: graduated from
//    - hobbies: user hobbies
//    - instagramLink: user instagram page
//    - facebookLink: user facebook page
//    - vkLink: user vk page
struct User {
    var name: String
    var surname: String
    var age: Int
    var status: String
    var city: String
    var pageStatus: String
    var avatar: String
    var phone: String
    var school: String
    let hobbies: String = "Чтение книг, курение дорогих сигар, распитие эксклюзивных алкогольных напитков"
    let instagramLink: String = "www.instagram.com"
    let facebookLink: String = "www.facebook.com"
    let vkLink: String = "www.vk.com"
}
