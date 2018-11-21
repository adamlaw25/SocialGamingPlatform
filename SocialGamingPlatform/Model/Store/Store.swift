//
//  Store.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/20/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import Firebase

class Store {
    var items : [StoreItem] = []
    var ref: DatabaseReference!
    
    init() {
        addItems()
        
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference(withPath: "users/\(uid!)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let gameList = (value?["gameList"] as? [String])!
            for game in gameList {
                for item in self.items {
                    if (game == item.name) {
                        self.remove(item: item)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addItems() {
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
    
    func remove(item: StoreItem) {
        if let index = items.index(where: { $0 === item }) {
            items.remove(at: index)
        }
    }
}
