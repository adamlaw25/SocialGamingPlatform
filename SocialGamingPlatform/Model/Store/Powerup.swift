//
//  Powerup.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class Powerup {
	var multiplier: Double
	var timeLimit: Int
	// var expirationTime: timestamp

	init(multiplier: Double, timeLimit: Int){
		self.multiplier = multiplier
		self.timeLimit = timeLimit
	}
}
