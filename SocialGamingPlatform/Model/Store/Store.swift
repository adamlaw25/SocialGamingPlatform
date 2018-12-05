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
    
    init() {
        addItems()
        removeExistingGames()
    }
    
    func addItems() {
        Constants.refs.databaseItems.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            // add the powerups from database
            let powerups = (value?["powerups"] as? NSDictionary)!
            for powerup in powerups {
                let powerupValue = (powerup.value as? NSDictionary)!
                let name = (powerupValue["name"] as? String)!
                let multiplier = (powerupValue["multiplier"] as? Int)!
                let price = (powerupValue["price"] as? Int)!
                let timeLimit = (powerupValue["timeLimit"] as? Int)!
                let item = StoreItem(name: name, price: price, detail: nil, power: Powerup(multiplier: multiplier, timeLimit: timeLimit))
                self.items.append(item)
            }
            
            // add the games from database
            let games = (value?["games"] as? NSDictionary)!
            for game in games {
                let gameValue = (game.value as? NSDictionary)!
                let name = (gameValue["name"] as? String)!
                let price = (gameValue["price"] as? Int)!
                let item = StoreItem(name: name, price: price, detail: "Enjoy the \(name) game!", power: nil)
                self.items.append(item)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func removeExistingGames() {
        Constants.refs.getCurrentUser().observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    func remove(item: StoreItem) {
        if let index = items.index(where: { $0 === item }) {
            items.remove(at: index)
        }
    }
}
