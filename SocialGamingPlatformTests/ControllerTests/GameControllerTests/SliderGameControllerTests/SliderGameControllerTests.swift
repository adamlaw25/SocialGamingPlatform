//
//  SliderGameControllerTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class SliderGameControllerTests: XCTestCase {
    
    var controller : SliderGameController!

    override func setUp() {
        controller = SliderGameController()
    }

    override func tearDown() {
        controller.resetGame()
    }

    func test_shuffle() {
        controller.board = [    [1,2,3],
                                [4,5,6],
                                [7,8,0]]
        controller.shuffle(n: 20)
        XCTAssertNotEqual(controller.board, [    [1,2,3],
                                                 [4,5,6],
                                                 [7,8,0]])
        controller.board = [    [1,2,3],
                                [4,5,6],
                                [7,8,0]]
        controller.shuffle(n: 0)
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,5,6],
                                              [7,8,0]])
    }
    
    func test_resetGame() {
        controller.board = [[1,2,3], [4,5,6], [7,8,0]]
        controller.numOfMoves = 20
        controller.game_state = .gameover
        controller.resetGame()
        XCTAssertNotEqual(controller.board, [[1,2,3], [4,5,6], [7,8,0]])
        XCTAssertEqual(controller.numOfMoves, 0)
        XCTAssertEqual(controller.game_state, .in_progress)
    }
    
    func test_move() {
        controller.board = [[1,2,3],
                            [4,5,6],
                            [7,8,0]]
        controller.numOfMoves = 0
        controller.move(direction: "UP")
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,5,0],
                                              [7,8,6]])
        XCTAssertEqual(controller.numOfMoves, 1)
        controller.move(direction: "LEFT")
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,0,5],
                                              [7,8,6]])
        XCTAssertEqual(controller.numOfMoves, 2)
        controller.move(direction: "DOWN")
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,8,5],
                                              [7,0,6]])
        XCTAssertEqual(controller.numOfMoves, 3)
        controller.move(direction: "RIGHT")
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,8,5],
                                              [7,6,0]])
        XCTAssertEqual(controller.numOfMoves, 4)
        //doesn't change the board or increment the number of moves when the move is invalid
        controller.move(direction: "RIGHT")
        XCTAssertEqual(controller.board, [    [1,2,3],
                                              [4,8,5],
                                              [7,6,0]])
        XCTAssertEqual(controller.numOfMoves, 4)
    }
    
    func test_hasWon() {
        controller.board = [    [1,2,3],
                                [4,5,0],
                                [7,8,6]]
        controller.blanktile_row = 1
        controller.blanktile_column = 2
        controller.move(direction: "DOWN")
        XCTAssertTrue(controller.hasWon())
        controller.board = [    [1,2,0],
                                [4,5,3],
                                [7,8,6]]
        controller.blanktile_row = 0
        controller.blanktile_column = 2
        controller.move(direction: "DOWN")
        XCTAssertFalse(controller.hasWon())
    }
    
    func test_updateGameState() {
        //test in_progress case
        controller.board = [    [1,2,3],
                                [4,5,6],
                                [7,8,0]]
        controller.numOfMoves = 5
        controller.score = 0
        controller.score_multipler = 2
        controller.updateGameState()
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertEqual(controller.score, (100-5) * 2)
        controller.board = [    [1,2,3],
                                [4,8,5],
                                [7,6,0]]
        controller.game_state = .in_progress
        controller.updateGameState()
        XCTAssertNotEqual(controller.game_state, .gameover)
        
        //test gameover case
        controller.board = [    [1,2,3],
                                [4,5,6],
                                [7,8,0]]
        controller.numOfMoves = 15
        controller.score = 0
        controller.score_multipler = 2
        controller.game_state = .gameover
        controller.updateGameState()
        XCTAssertEqual(controller.score, (100-15) * 2)
        
    }

}
