//
//  StoreItemList.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class StoreItemList {
    var items : [StoreItem] = []
    
    init() {
        let powerup1 = Powerup(multiplier: 2, timeLimit: 3600)
        let powerup2 = Powerup(multiplier: 3, timeLimit: 3600)
        let item1 = StoreItem(name: "2x Power Up", price: 20, detail: nil, power: powerup1)
        let item2 = StoreItem(name: "3x Power Up", price: 30, detail: nil, power: powerup2)
        items.append(item1)
        items.append(item2)
        
        let item3 = StoreItem(name: "Connect4", price: 30, detail: "The great Connect4 game", power: nil)
        let item4 = StoreItem(name: "Slider", price: 30, detail: "The great Slider game", power: nil)
        items.append(item3)
        items.append(item4)
    }
}
