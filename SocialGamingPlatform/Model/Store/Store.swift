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
	var gamesList = ["Connect4"]

	init() {
		powerupList = [Powerup(multiplier: 2.0, timeLimit: 3600), Powerup(multiplier: 3.0, timeLimit: 3600)]
	}
}