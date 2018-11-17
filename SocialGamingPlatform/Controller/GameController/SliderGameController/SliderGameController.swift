//
//  File.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/15/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

enum SliderGameState: Int {
    case in_progress = 0, gameover
}

class SliderGameController {
    
    var board : [[Int]]
    var blanktile_row : Int
    var blanktile_column : Int
    var numOfMoves : Int
    var score: Int
    var game_state : SliderGameState
    var score_multipler : Int
    
    init() {
        self.board = [[1,2,3], [4,5,6], [7,8,0]]
        self.blanktile_row = 2
        self.blanktile_column = 2
        self.numOfMoves = 0
        self.score = 0
        self.game_state = .in_progress
        self.score_multipler = 1
    }
    
    func shuffle(n: Int) {
        print(n)
        var directions = getCurrentAvailableMoves()
        var random_number  = Int.random(in: 0..<directions.count)
        for _ in 0..<n {
            move(direction: directions[random_number])
            updateBlankTile()
            directions = getCurrentAvailableMoves()
            random_number = Int.random(in: 0..<directions.count)
        }
    }
    
    private func getCurrentAvailableMoves() -> [String] {
        var directions = [String]()
        if blanktile_row > 0 {
            directions.append("UP")
        }
        if blanktile_row < 2 {
            directions.append("DOWN")
        }
        if blanktile_column > 0 {
            directions.append("LEFT")
        }
        if blanktile_column < 2 {
            directions.append("RIGHT")
        }
        return directions
    }
    
    func resetGame() {
        self.board = [[1,2,3], [4,5,6], [7,8,0]]
        let difficulty_index = calculateDifficulty()
        self.shuffle(n: difficulty_index)
        self.updateBlankTile()
        self.numOfMoves = 0
        self.game_state = .in_progress
    }
    
    private func calculateDifficulty() -> Int {
        return 5 + score/50
    }
    
    func move(direction: String) {
        switch direction {
        case "UP":
            if blanktile_row > 0 {
                let temp = board[blanktile_row-1][blanktile_column]
                board[blanktile_row-1][blanktile_column] = board[blanktile_row][blanktile_column]
                board[blanktile_row][blanktile_column] = temp
                numOfMoves += 1
            }
            break
        case "DOWN":
            if blanktile_row < 2 {
                let temp = board[blanktile_row+1][blanktile_column]
                board[blanktile_row+1][blanktile_column] = board[blanktile_row][blanktile_column]
                board[blanktile_row][blanktile_column] = temp
                numOfMoves += 1
            }
            break
        case "LEFT":
            if blanktile_column > 0 {
                let temp = board[blanktile_row][blanktile_column-1]
                board[blanktile_row][blanktile_column-1] = board[blanktile_row][blanktile_column]
                board[blanktile_row][blanktile_column] = temp
                numOfMoves += 1
            }
            break
        case "RIGHT":
            if blanktile_column < 2 {
                let temp = board[blanktile_row][blanktile_column+1]
                board[blanktile_row][blanktile_column+1] = board[blanktile_row][blanktile_column]
                board[blanktile_row][blanktile_column] = temp
                numOfMoves += 1
            }
            break
        default:
            //throw error
            break
        }
        updateBlankTile()
    }
    
    func hasWon() -> Bool {
        return board[0] == [1,2,3] &&
            board[1] == [4,5,6] &&
            board[2] == [7,8,0]
    }
    
    private func updateBlankTile() {
        for row in 0...2 {
            for column in 0...2 {
                if board[row][column] == 0 {
                    blanktile_row = row
                    blanktile_column = column
                }
            }
        }
    }
    
    private func awardScore() {
        self.score += ((100 - numOfMoves) * score_multipler)
    }
    
    func gameOverNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Slider Game Over"), object: self, userInfo: ["numOfMoves": numOfMoves])
    }
    
    func updateGameState() {
        switch game_state {
        case .in_progress:
            if hasWon() {
                updateToGameOver()
            }
            break
        case .gameover:
            gameoverAction()
            break
        }
    }
    
    private func updateToGameOver() {
        game_state = .gameover
        gameoverAction()
    }
    
    private func gameoverAction() {
        awardScore()
        gameOverNotification()
    }
    
    
    //for debugging purposes: print the gameboard
    private func printBoard() {
        for row in board {
            print(row)
        }
        print("\n")
    }
}
