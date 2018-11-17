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
 * 0=empty; 1=player red puck; 2=computer yellow puck
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
        if isColumnFull(column: column) {
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
    }
    
    func isColumnFull(column: Int) -> Bool{
        return firstEmptyRow(column: column) == -1
    }
    
    func firstEmptyRow(column: Int) -> Int {
        var empty_row = -1
        for row in 0...5{
            if game_board[row][column] == 0 {
                empty_row += 1
            }
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
        for column in 0...5 {
            for row in 0...2 {
                if game_board[row][column] != puck_num {
                    continue
                }
                if game_board[row][column] == game_board[row+1][column]
                    && game_board[row+2][column] == game_board[row+3][column]
                    && game_board[row+1][column] == game_board[row+2][column] {
                    return true
                }
            }
        }
        return false
    }
    
    private func has4Horizontal(puck: Puck) -> Bool {
        let puck_num = puck.rawValue
        for row in 0...5 {
            for column in 0...2 {
                if game_board[row][column] != puck_num {
                    continue
                }
                if game_board[row][column] == game_board[row][column+1]
                    && game_board[row][column+2] == game_board[row][column+3]
                    && game_board[row][column+1] == game_board[row][column+2] {
                    return true
                }
            }
        }
        return false
    }
    
    private func has4Diagonal(puck: Puck) -> Bool {
        for row in 0...5 {
            for column in 0...5 {
                let positive_diagonal = getPositiveDiagonal(row: row, column: column)
                let negative_diagonal = getNegativeDiagonal(row: row, column: column)
                if positive_diagonal.count < 4 && negative_diagonal.count < 4 {
                    continue
                }
                if checkDiagonal(puck: puck, diagonal: positive_diagonal) ||
                    checkDiagonal(puck: puck, diagonal: negative_diagonal) {
                    return true
                }
            }
        }
        return false
    }
    
    private func checkDiagonal(puck: Puck, diagonal: [Int]) -> Bool {
        let puck_num = puck.rawValue
        var cur_index = 0
        if diagonal.count < 4 {
            return false
        }
        while cur_index + 3 < diagonal.count {
            if diagonal[cur_index] != puck_num {
                cur_index += 1
                continue
            }
            if diagonal[cur_index] == diagonal[cur_index+1] &&
                diagonal[cur_index+2] == diagonal[cur_index+3] &&
                diagonal[cur_index+1] == diagonal[cur_index+2] {
                return true
            }
            cur_index += 1
        }
        return false
    }
    
    private func getPositiveDiagonal(row: Int, column: Int) -> [Int]{
        //retrieve upper diagonal: slope = 1
        var diagonal = [Int]()
        var i = row
        var j = column
        while (i >= 0) && (j <= 5) {
            diagonal.append(game_board[i][j])
            i-=1
            j+=1
        }
        //retrieve lower diagonal: slope = 1
        i = row + 1
        j = column - 1
        while (i <= 5) && (j >= 0) {
            diagonal.insert(game_board[i][j], at: 0)
            i+=1
            j-=1
        }
        return diagonal
    }
    
    private func getNegativeDiagonal(row: Int, column: Int) -> [Int]{
        //retrieve upper diagonal: slope = -1
        var diagonal = [Int]()
        var i = row
        var j = column
        while (i >= 0) && (j >= 0) {
            diagonal.append(game_board[i][j])
            i-=1
            j-=1
        }
        //retrieve lower diagonal: slope = -1
        i = row + 1
        j = column + 1
        while (i <= 5) && (j <= 5) {
            diagonal.insert(game_board[i][j], at: 0)
            i+=1
            j+=1
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
    
    private func gameOverNotification() {
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
            game_state = .computer_state
            break
        case .computer_state:
            if has4ConnectedPuckOf(puck: .computer_puck) {
                updateToGameOver(didComputerWin: true)
            }
            if isBoardFull() {
                updateToGameOver(didComputerWin: false)
            }
            game_state = .player_state
            break
        case .gameover:
            determineWinner()
            break
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
        print("\n")
    }
    
    
}
