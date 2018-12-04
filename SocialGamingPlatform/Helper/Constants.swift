//
//  Constants.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 12/4/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("messages")
        static let users = databaseRoot.child("users")
        static let currentUserid = (Auth.auth().currentUser?.uid)!
        static let currentUserEmail = (Auth.auth().currentUser?.email)!
        static let currentUser = users.child("\(currentUserid)")
    }
}
