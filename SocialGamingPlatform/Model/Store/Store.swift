//
//  Store.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class Store {
	var powerupList: [Powerup]
	var gamesList = ["Connect4", "Slider"]

	init() {
		powerupList = [Powerup(multiplier: 2, timeLimit: 3600), Powerup(multiplier: 3, timeLimit: 3600)]
	}
}
