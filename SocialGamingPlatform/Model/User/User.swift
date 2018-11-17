//
//  User.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

//a class that represents the user
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
        self.powerup = Powerup(multiplier: 1, timeLimit: 0)
    }

    //increments the level by one
    func levelUP() {
    	self.level += 1
    }

    //add a friend to this user
    //input: another user object
    func addFriend(friend: User) {
    	self.friends += [friend]
    }

    //add score to this user
    //input: amount of score to be added
    func addScore(newScore: Int) {
    	self.score += newScore * powerup.multiplier
    }

    //set the online status of this user
    //input: online status
    func setStatus(isOnline: Bool) {
    	self.isOnline = isOnline
    }

    //apply a powerup to this user
    //input: a powerup
    func applyPowerup(powerup: Powerup) {
    	self.powerup = powerup
    }
}
