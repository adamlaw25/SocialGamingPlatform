//
//  Constants.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 12/4/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("messages")
        static let databaseItems = databaseRoot.child("items")
        static let users = databaseRoot.child("users")
        static func getCurrentUserID() -> String {
            return (Auth.auth().currentUser?.uid)!
        }
        static func getCurrentUserEmail() -> String {
            return (Auth.auth().currentUser?.email)!
        }
        static func getCurrentUser() -> DatabaseReference {
            return users.child("\(getCurrentUserID())")
        }
    }
}
