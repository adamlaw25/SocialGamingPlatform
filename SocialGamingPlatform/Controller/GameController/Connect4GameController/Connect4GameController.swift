//
//  Connect4GameController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/14/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

enum Connect4GameState: Int {
    case player_state = 0, computer_state, gameover
}

class Connect4GameController {
    
    var game_board : [[Int]]
    
    init() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
        printBoard()
    }
    
    //for debugging purposes, print the entire gameboard in the console
    func printBoard() {
        for array in game_board {
            print(array)
        }
    }
    
    //reset the game
    func resetGame() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    }
    
    
}
