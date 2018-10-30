//
//  Game.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class Game {
	var points = 0
	var player: User

	init(player: User) {
		self.player = player
    }

    func hasWon(isWon: Bool) -> Bool {
    	return isWon
    }
}
