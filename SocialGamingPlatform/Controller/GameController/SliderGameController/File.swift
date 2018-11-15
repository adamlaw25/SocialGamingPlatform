//
//  File.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/15/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

class SliderGameController {
    
    var board : [[Int]]
    
    var blanktile_row : Int
    
    var blanktile_column : Int
    
    var numOfMoves : Int
    
    init() {
        self.board = [[1,2,3], [4,5,6], [7,8,0]]
        self.blanktile_row = 2
        self.blanktile_column = 2
        self.numOfMoves = 0
    }
    
    func shuffle() {
        
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
    }
    
    private func findBlankTile() {
        for row in 0...2 {
            for column in 0...2 {
                if board[row][column] == 0 {
                    
                }
            }
        }
    }
    
    
    
    //for debugging purposes: print the gameboard
    private func printBoard() {
        for row in board {
            print(row)
        }
        print("\n")
    }
    
    
    
    
    
    
    
}
