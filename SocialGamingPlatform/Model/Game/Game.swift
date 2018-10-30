//
//  Game.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class Game {
    var points: Double
	var player: User

	init(player: User) {
		self.player = player
        self.points = 0.0
    }

    func hasWon(isWon: Bool) -> Bool {
    	return isWon
    }
}
