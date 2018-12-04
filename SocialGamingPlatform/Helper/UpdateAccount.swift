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
    // increase score method which multiplies the increase score with the multiplier
    static func increaseScore(increase: Int) {
        let user = Constants.refs.currentUser
        user.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = (value?["score"] as? Int)!
            let powerup = (value?["powerup"] as? NSDictionary)!
            let multiplier = (powerup["multiplier"] as? Int)!
            user.updateChildValues(["score": score + increase * multiplier])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // decrease score method which does not multiply the multiplier
    static func reduceScore(decrease: Int) {
        let user = Constants.refs.currentUser
        user.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = (value?["score"] as? Int)!
            user.updateChildValues(["score": score - decrease])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // increase the user level by 1
    static func levelUp() {
        let user = Constants.refs.currentUser
        user.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let level = (value?["level"] as? Int)!
            user.updateChildValues(["level": level + 1])
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
