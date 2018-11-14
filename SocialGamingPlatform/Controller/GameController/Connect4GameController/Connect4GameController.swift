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
    case player_state = 0, computer_state, gameover
}

enum Puck: Int {
    case empty = 0, player_puck, computer_puck
}

class Connect4GameController {
    
    var game_board : [[Int]]
    var game_state : Connect4GameState
    var score : Int
    var didComputerWin : Bool
    var score_multiplier : Int
    var player_pucks : Int
    var comp_pucks : Int
    
    init() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
        self.game_state = .player_state
        self.score = 0
        self.didComputerWin = false
        self.score_multiplier = 1
        player_pucks = 0
        comp_pucks = 0
    }
    
    //reset the game
    func resetGame() {
        resetGameBoard()
        self.game_state = .player_state
        self.didComputerWin = false
        player_pucks = 0
        comp_pucks = 0
    }
    
    //private method resetting gameboard
    private func resetGameBoard() {
        self.game_board = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    }
    
    //dropping a puck into the game board
    func dropPuck(column: Int) {
        let row_num = firstEmptyRow(column: column)
        if row_num == -1 {
            //throw error: column full
            return
        }
        if game_state == .player_state {
            dropPuckAt(row: row_num, column: column, puck: .player_puck)
            player_pucks += 1
        }
        else if game_state == .computer_state {
            dropPuckAt(row: row_num, column: column, puck: .computer_puck)
            comp_pucks += 1
        }
        else {
            //throw error: game already over
        }
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
    
    private func dropPuckAt(row: Int, column: Int, puck: Puck) {
        game_board[row][column] = puck.rawValue
    }
    
    func has4ConnectedPuckOf(puck: Puck) -> Bool {
        return has4Vertical(puck: puck) || has4Horizontal(puck: puck) || has4Diagonal(puck: puck)
    }
    
    private func has4Vertical(puck: Puck) -> Bool {
        let puck_num = puck.rawValue
        var checksum = 0
        for column in 0...5 {
            for row in 0...2 {
                if game_board[row][column] != puck_num {
                    continue
                }
                checksum = game_board[row][column] + game_board[row+1][column]
                    + game_board[row+2][column] + game_board[row+3][column]
                if checksum == puck_num * 4 {
                    return true
                }
            }
        }
        return false
    }
    
    private func has4Horizontal(puck: Puck) -> Bool {
        let puck_num = puck.rawValue
        var checksum = 0
        for row in 0...5 {
            for column in 0...2 {
                if game_board[row][column] != puck_num {
                    continue
                }
                checksum = game_board[row][column] + game_board[row][column+1]
                    + game_board[row][column+2] + game_board[row][column+3]
                if checksum == puck_num * 4 {
                    return true
                }
            }
        }
        return false
    }
    
    private func has4Diagonal(puck: Puck) -> Bool {
        let puck_num = puck.rawValue
        var checksum = 0
        var cur_index = 0
        for row in 0...5 {
            for column in 0...5 {
                let diagonal = getDiagonalAt(row: row, column: column)
                if diagonal.count < 4 {
                    continue
                }
                while cur_index + 3 < diagonal.count {
                    if diagonal[cur_index] != puck_num {
                        continue
                    }
                    checksum = diagonal[cur_index] + diagonal[cur_index+1]
                        + diagonal[cur_index+2] + diagonal[cur_index+3]
                    if checksum == puck_num * 4 {
                        return true
                    }
                    cur_index += 1
                }
            }
        }
        return false
    }
    
    private func getDiagonalAt(row: Int, column: Int) -> [Int]{
        //retrieve first diagonal: slope = 1
        var diagonal = [Int]()
        var i = row
        var j = column
        while (i >= 0) && (j <= 5) {
            diagonal.append(game_board[i][j])
            i-=1
            j+=1
        }
        //retrieve second diagonal: slope = -1
        i = row + 1
        j = column - 1
        while (i <= 5) && (j >= 0) {
            diagonal.insert(game_board[i][j], at: 0)
        }
        return diagonal
    }
    
    func awardScore() {
        if didComputerWin {
            score -= 50
        }
        else {
            score += score_multiplier * 50
        }
    }
    
    func gameOverNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Connect4 Game Over"), object: self, userInfo: ["didComputerWin": didComputerWin])
    }
    
    func updateGameState() {
        switch game_state {
        case .player_state:
            if has4ConnectedPuckOf(puck: .player_puck) {
                updateToGameOver(didComputerWin: false)
            }
            if isBoardFull() {
                updateToGameOver(didComputerWin: false)
            }
            break
        case .computer_state:
            if has4ConnectedPuckOf(puck: .computer_puck) {
                updateToGameOver(didComputerWin: true)
            }
            if isBoardFull() {
                updateToGameOver(didComputerWin: false)
            }
            break
        case .gameover:
            determineWinner()
        }
    }
    
    private func updateToGameOver(didComputerWin: Bool) {
        game_state = .gameover
        self.didComputerWin = didComputerWin
        awardScore()
        gameOverNotification()
    }
    
    private func determineWinner() {
        if has4ConnectedPuckOf(puck: .computer_puck) {
            didComputerWin = true
        }
        else if has4ConnectedPuckOf(puck: .player_puck) {
            didComputerWin = false
        }
        else {
            didComputerWin = false
        }
        awardScore()
        gameOverNotification()
    }
    
    private func isBoardFull() -> Bool {
        return totalNumOfPucks() >= 36
    }
    
    private func totalNumOfPucks() -> Int {
        return player_pucks + comp_pucks
    }
    
    //for debugging purposes, print the entire gameboard in the console
    private func printBoard() {
        for array in game_board {
            print(array)
        }
    }
    
    
}