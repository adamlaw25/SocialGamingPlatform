//
//  Powerup.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class Powerup {
	var multiplier: Int
	var timeLimit: Int
	// var expirationTime: timestamp

	init(multiplier: Int, timeLimit: Int){
		self.multiplier = multiplier
		self.timeLimit = timeLimit
	}
}
