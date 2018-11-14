//
//  Connect4GameController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/14/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

/*
 6x6 GameBoard representation:
        column
 row    0 0 0 0 0 0
        0 0 0 0 0 0
        1 0 2 0 0 2
        1 0 1 2 0 1
        2 0 2 1 2 2
        1 1 2 2 1 2
 * 0=empty; 1=player yellow puck; 2=computer red puck
 */

import Foundation

enum Connect4GameState: Int {
    case player_state = 0, computer_state, board_full, gameover
}

enum Puck: Int {
    case empty = 0, player_puck, computer_puck
}

class Connect4GameController {
    
    var game_board : [[Int]]
    var game_state : Connect4GameState
    var score : Int
    var didDealerWin : Bool
    var score_multiplier : Int
    
    init() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
        self.game_state = .player_state
        self.score = 0
        self.didDealerWin = false
        self.score_multiplier = 1
        printBoard()
    }
    
    //reset the game
    func resetGame() {
        resetGameBoard()
        self.game_state = .player_state
        self.didDealerWin = false
    }
    
    //dropping a puck into the game board
    func dropPuck(column: Int) {
        let row_num = firstEmptyRow(column: column)
        if game_state == .player_state {
            dropPuckAt(row: row_num, column: column, puck: .player_puck)
        }
        else if game_state == .computer_state {
            dropPuckAt(row: row_num, column: column, puck: .computer_puck)
        }
        else {
            //throw error
        }
    }
    
    func checkWinner() {
        
    }
    
    private func dropPuckAt(row: Int, column: Int, puck: Puck) {
        game_board[row][column] = puck.rawValue
    }
    
    private func firstEmptyRow(column: Int) -> Int {
        var empty_row = 7
        for row in game_board {
            if row[column] == 0 {
                empty_row-=1
            }
            else {
                break;
            }
        }
        if empty_row == 7 {
            return -1
        }
        return empty_row
    }
    
    //for debugging purposes, print the entire gameboard in the console
    private func printBoard() {
        for array in game_board {
            print(array)
        }
    }
    
    //private method resetting gameboard
    private func resetGameBoard() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    }
    
    
}
