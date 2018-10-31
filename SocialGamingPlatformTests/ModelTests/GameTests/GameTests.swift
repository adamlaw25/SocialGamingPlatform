//
//  GameTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class GameTests: XCTestCase {
    
    var game : Game!
    
    var user : User!

    override func setUp() {
        super.setUp()
        user = User(email: "test@test.com")
        game = Game(player: user)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_hasWon() {
        XCTAssertTrue(game.hasWon(isWon: true))
        XCTAssertFalse(game.hasWon(isWon: false))
    }

}
