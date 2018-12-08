//
//  Connect4GameControllerTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class Connect4GameControllerTests: XCTestCase {
    
    var controller : Connect4GameController!

    override func setUp() {
        controller = Connect4GameController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        controller.resetGame()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_resetGame() {
        controller.resetGame()
        XCTAssertEqual(controller.game_state, .player_state)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.player_pucks, 0)
        XCTAssertEqual(controller.comp_pucks, 0)
        XCTAssertEqual(controller.game_board, Array(repeating: Array(repeating: 0, count: 6), count: 6))
        tearDown()
    }
    
//    func test_dropPuck() {
//        //test adding player puck
//        controller.game_state = .player_state
//        controller.dropPuck(column: 0)
//        XCTAssertEqual(controller.game_board,
//                       [   [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [1,0,0,0,0,0]])
//        XCTAssertEqual(controller.player_pucks, 1)
//        XCTAssertEqual(controller.comp_pucks, 0)
//        //test adding computer puck
//        controller.game_state = .computer_state
//        controller.dropPuck(column: 1)
//        XCTAssertEqual(controller.game_board,
//                       [   [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [0,0,0,0,0,0],
//                           [1,2,0,0,0,0]])
//        XCTAssertEqual(controller.player_pucks, 1)
//        XCTAssertEqual(controller.comp_pucks, 1)
//        //test adding pucks on top of other pucks
//        controller.game_state = .player_state
//        controller.dropPuck(column: 1)
//        controller.game_state = .computer_state
//        controller.dropPuck(column: 0)
//        XCTAssertEqual(controller.game_board, [   [0,0,0,0,0,0],
//                                                  [0,0,0,0,0,0],
//                                                  [0,0,0,0,0,0],
//                                                  [0,0,0,0,0,0],
//                                                  [2,1,0,0,0,0],
//                                                  [1,2,0,0,0,0]])
//        //test adding a puck to a full column
//        controller.game_board = [   [0,0,1,0,0,0],
//                                    [0,0,1,0,0,0],
//                                    [0,0,1,0,0,0],
//                                    [0,0,1,0,0,0],
//                                    [0,0,1,0,0,0],
//                                    [0,0,1,0,0,0]]
//        controller.player_pucks = 6
//        controller.game_state = .player_state
//        controller.dropPuck(column: 2)
//        XCTAssertEqual(controller.game_board,
//                       [   [0,0,1,0,0,0],
//                           [0,0,1,0,0,0],
//                           [0,0,1,0,0,0],
//                           [0,0,1,0,0,0],
//                           [0,0,1,0,0,0],
//                           [0,0,1,0,0,0]])
//        XCTAssertEqual(controller.player_pucks, 6)
//        tearDown()
//    }
    
    func test_isColumnFull() {
        controller.game_board = [   [0,0,0,0,0,1],
                                    [0,0,0,0,2,1],
                                    [0,0,0,0,2,1],
                                    [0,0,0,1,2,1],
                                    [0,0,2,1,2,1],
                                    [0,1,2,1,2,1]]
        XCTAssertFalse(controller.isColumnFull(column: 0))
        XCTAssertFalse(controller.isColumnFull(column: 3))
        XCTAssertTrue(controller.isColumnFull(column: 5))
        tearDown()
    }
    
    func test_firstEmptyRow() {
        controller.game_board = [   [0,0,0,0,0,1],
                                    [0,0,0,0,2,1],
                                    [0,0,0,0,2,1],
                                    [0,0,0,1,2,1],
                                    [0,0,2,1,2,1],
                                    [0,1,2,1,2,1]]
        XCTAssertEqual(controller.firstEmptyRow(column: 0), 5)
        XCTAssertEqual(controller.firstEmptyRow(column: 1), 4)
        XCTAssertEqual(controller.firstEmptyRow(column: 2), 3)
        XCTAssertEqual(controller.firstEmptyRow(column: 3), 2)
        XCTAssertEqual(controller.firstEmptyRow(column: 4), 0)
        XCTAssertEqual(controller.firstEmptyRow(column: 5), -1)
        tearDown()
    }
    
    func test_has4ConnectedPuckOf() {
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [1,0,0,0,0,2]]
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .computer_puck))
        //test vertical
        controller.game_board = [   [0,0,0,0,0,2],
                                    [1,0,0,0,0,2],
                                    [1,0,0,0,0,2],
                                    [1,0,0,0,0,2],
                                    [1,0,0,0,0,1],
                                    [2,0,0,0,0,1]]
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .computer_puck))
        //test horizontal
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,1,1,1],
                                    [2,2,2,2,1,1]]
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .computer_puck))
        //test diagonal
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,2,0,0],
                                    [0,0,2,1,0,0],
                                    [1,2,1,1,1,2],
                                    [2,1,1,2,2,1]]
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .computer_puck))
        tearDown()
    }
    
    func test_awardScore() {
        controller.score = 0
        controller.score_multiplier = 2
        controller.didComputerWin = true
        controller.awardScore()
        XCTAssertEqual(controller.score, 0)
        controller.score = 0
        controller.didComputerWin = false
        controller.awardScore()
        XCTAssertEqual(controller.score, 50*2)
    }
    
    func test_updateGameState() {
        //test player_state case
        
        //if player has 4 connected pucks
        controller.game_state = .player_state
        controller.score = 0
        controller.score_multiplier = 1
        controller.player_pucks = 4
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0]]
        controller.updateGameState()
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 50)
        //if the board is full
        controller.game_state = .player_state
        controller.score = 0
        controller.player_pucks = 18
        controller.comp_pucks = 18
        controller.game_board = [   [2,1,2,1,2,1],
                                    [2,1,2,1,2,1],
                                    [2,1,2,1,2,1],
                                    [1,2,1,2,1,2],
                                    [1,2,1,2,1,2],
                                    [1,2,1,2,1,2]]
        controller.updateGameState()
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 50)
        //if the player does not have 4 connected pucks
        controller.score = 0
        controller.game_state = .player_state
        controller.player_pucks = 3
        controller.comp_pucks = 3
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,2,2,2]]
        controller.updateGameState()
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .player_puck))
        XCTAssertEqual(controller.game_state, .computer_state)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 0)
        //test computer_state case
        
        //if the computer has 4 connected pucks
        controller.game_state = .computer_state
        controller.score = 0
        controller.comp_pucks = 4
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,2,0,0,0],
                                    [0,0,2,0,0,0],
                                    [0,0,2,0,0,0],
                                    [0,0,2,0,0,0]]
        controller.updateGameState()
        XCTAssertTrue(controller.has4ConnectedPuckOf(puck: .computer_puck))
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertTrue(controller.didComputerWin)
        XCTAssertEqual(controller.score, 0)
        //if the board is full
        controller.game_state = .computer_state
        controller.score = 0
        controller.player_pucks = 18
        controller.comp_pucks = 18
        controller.game_board = [   [2,1,2,1,2,1],
                                    [2,1,2,1,2,1],
                                    [2,1,2,1,2,1],
                                    [1,2,1,2,1,2],
                                    [1,2,1,2,1,2],
                                    [1,2,1,2,1,2]]
        controller.updateGameState()
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .computer_puck))
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 50)
        //if the computer does not have 4 connected pucks
        controller.score = 0
        controller.game_state = .computer_state
        controller.player_pucks = 3
        controller.comp_pucks = 3
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,2,2,2]]
        controller.updateGameState()
        XCTAssertFalse(controller.has4ConnectedPuckOf(puck: .computer_puck))
        XCTAssertEqual(controller.game_state, .player_state)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 0)
        //test gameover case
        
        //if the game is over
        controller.game_state = .gameover
        controller.score = 0
        controller.game_board = [   [0,0,0,0,0,0],
                                    [0,0,0,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,0,0,0],
                                    [0,0,1,2,2,2]]
        controller.updateGameState()
        XCTAssertEqual(controller.game_state, .gameover)
        XCTAssertFalse(controller.didComputerWin)
        XCTAssertEqual(controller.score, 50)
    }
}
