//
//  User.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class User {
	var email: String
	var isOnline: Bool
	var score: Int
	var level: Int
	var friends: [User]
	var gameList: [String]
	var powerup: Powerup

	init(email: String) {
		self.email = email
		self.isOnline = false
		// databases methods to retrieve data
		self.score = 0
		self.level = 1
		self.friends = []
		self.gameList = ["BlackJack"]
        //Default powerup
        self.powerup = Powerup(multiplier: 1.0, timeLimit: 0)
    }

    func levelUP() {
    	self.level += 1
    }

    func addFriend(friend: User) {
    	self.friends += [friend]
    }

    func addScore(score: Int) {
    	self.score += score
    }

    func setStatus(isOnline: Bool) {
    	self.isOnline = isOnline
    }

    func applyPowerup(powerup: Powerup) {
    	self.powerup = powerup
    }
}
