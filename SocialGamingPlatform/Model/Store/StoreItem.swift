//
//  StoreItem.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class StoreItem {
    var name: String
    var price: Int
    var detail: String
    var powerUp: Powerup?
    
    init(name: String, price: Int, detail: String?, power: Powerup?) {
        self.name = name
        self.price = price
        if power != nil {
            self.powerUp = power
            self.detail = "multiplier: " + String(powerUp!.multiplier) + "\ntime limit: " + String(powerUp!.timeLimit)
        } else {
            self.detail = detail!
        }
    }
}
