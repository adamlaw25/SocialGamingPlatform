//
//  UpdateAccount.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 12/3/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import Firebase

class UpdateAccount {
    static func increaseScore(increase: Int) {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference(withPath: "users/\(uid!)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = (value?["score"] as? Int)!
            let powerup = (value?["powerup"] as? NSDictionary)!
            let multiplier = (powerup["multiplier"] as? Int)!
            ref.updateChildValues(["score": score + increase * multiplier])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func reduceScore(decrease: Int) {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference(withPath: "users/\(uid!)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = (value?["score"] as? Int)!
            ref.updateChildValues(["score": score + decrease])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func levelUp() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference(withPath: "users/\(uid!)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let level = (value?["level"] as? Int)!
            ref.updateChildValues(["level": level + 1])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
