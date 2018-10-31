//
//  BJGameControllerTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class BJGameControllerTests: XCTestCase {
    
    var bjcontroller : BJGameController!

    override func setUp() {
        bjcontroller = BJGameController()
        bjcontroller.resetGame()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        bjcontroller.resetGame()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_resetGame() {
        bjcontroller.cards = [Card(suit: .heart, digit: 3)]
        bjcontroller.playerCards = [Card(suit: .club, digit: 1)]
        bjcontroller.dealerCards = [Card(suit: .diamond, digit: 2)]
        bjcontroller.gameState = .gameoverState
        bjcontroller.resetGame()
        XCTAssertTrue(bjcontroller.cards.count == 52)
        XCTAssertTrue(bjcontroller.playerCards.count == 0)
        XCTAssertTrue(bjcontroller.dealerCards.count == 0)
        XCTAssertTrue(bjcontroller.gameState == .playerState)
        tearDown()
    }
    
    func test_nextDealerCard() {
        var tempDeck = bjcontroller.cards
        let tempCard = tempDeck.removeFirst()
        XCTAssertTrue(bjcontroller.dealerCards.count == 0)
        let firstCard = bjcontroller.nextDealerCard()
        XCTAssertEqual(firstCard.digit, tempCard.digit)
        XCTAssertEqual(firstCard.suit, tempCard.suit)
        XCTAssertTrue(bjcontroller.dealerCards.count == 1)
        tearDown()
    }
    
    func test_nextPlayerCard() {
        var tempDeck = bjcontroller.cards
        let tempCard = tempDeck.removeFirst()
        XCTAssertTrue(bjcontroller.playerCards.count == 0)
        let firstCard = bjcontroller.nextPlayerCard()
        XCTAssertEqual(firstCard.digit, tempCard.digit)
        XCTAssertEqual(firstCard.suit, tempCard.suit)
        XCTAssertTrue(bjcontroller.playerCards.count == 1)
        tearDown()
    }
    
    

}
