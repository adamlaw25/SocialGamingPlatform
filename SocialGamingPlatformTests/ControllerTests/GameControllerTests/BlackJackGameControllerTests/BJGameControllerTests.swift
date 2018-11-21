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
    let heartTen = Card(suit: .heart, digit: 10)
    let heartAce = Card(suit: .heart, digit: 1)
    let heartSix = Card(suit: .heart, digit: 6)
    let heartTwo = Card(suit: .heart, digit: 2)
    let clubFive = Card(suit: .club, digit: 5)

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
    
    func test_dealerCardAt() {
        bjcontroller.dealerCards = [heartTen]
        let firstCard = bjcontroller.dealerCardAt(index: 0)!
        XCTAssertEqual(firstCard.digit, 10)
        XCTAssertEqual(firstCard.suit, .heart)
        tearDown()
    }
    
    func test_playerCardAt() {
        bjcontroller.playerCards = [heartTen]
        let firstCard = bjcontroller.playerCardAt(index: 0)!
        XCTAssertEqual(firstCard.digit, 10)
        XCTAssertEqual(firstCard.suit, .heart)
        tearDown()
    }
    
    func test_areCardsOver21() {
        let over21 = [heartTen, heartTen, clubFive]
        let exactly21 = [heartTen, heartSix, clubFive]
        let under21 = [heartSix, clubFive]
        XCTAssertTrue(bjcontroller.areCardsOver21(over21))
        XCTAssertFalse(bjcontroller.areCardsOver21(exactly21))
        XCTAssertFalse(bjcontroller.areCardsOver21(under21))
    }
    
    func test_isBlackJack() {
        bjcontroller.playerCards = [heartTen, heartAce]
        XCTAssertTrue(bjcontroller.isBlackJack())
        bjcontroller.playerCards = [heartTen, heartTen]
        XCTAssertFalse(bjcontroller.isBlackJack())
    }
    
    func test_calculateBestScore() {
        let over21 = [heartTen, heartTen, heartTen]
        let aceIsEleven = [heartAce, heartSix]
        let testTen = [heartTen, heartSix]
        let testDigit = [heartSix, heartSix]
        let aceIsOne = [heartTen, heartTen, heartAce]
        XCTAssertEqual(bjcontroller.calculateBestScore(over21), 0)
        XCTAssertEqual(bjcontroller.calculateBestScore(aceIsEleven), 17)
        XCTAssertEqual(bjcontroller.calculateBestScore(testTen), 16)
        XCTAssertEqual(bjcontroller.calculateBestScore(testDigit), 12)
        XCTAssertEqual(bjcontroller.calculateBestScore(aceIsOne), 21)
    }
    
    func test_updateGameState() {
        // player state
        bjcontroller.gameState = .playerState
        bjcontroller.playerCards = [heartTen, heartAce]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .gameoverState)
        XCTAssertFalse(bjcontroller.didDealerWin)
        bjcontroller.gameState = .playerState
        bjcontroller.playerCards = [heartTen, heartTen, heartTen]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .gameoverState)
        XCTAssertTrue(bjcontroller.didDealerWin)
        bjcontroller.gameState = .playerState
        bjcontroller.playerCards = [heartTwo, heartTwo, heartTwo, heartTwo, heartTwo]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .dealerState)
        
        // dealer state
        bjcontroller.gameState = .dealerState
        bjcontroller.dealerCards = [heartTen, heartTen, heartTen]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .gameoverState)
        XCTAssertFalse(bjcontroller.didDealerWin)
        bjcontroller.gameState = .dealerState
        bjcontroller.dealerCards = [heartTwo, heartTwo, heartTwo, heartTwo, heartTwo]
        bjcontroller.playerCards = [heartTwo, heartTwo]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .gameoverState)
        XCTAssertTrue(bjcontroller.didDealerWin)
        bjcontroller.gameState = .dealerState
        bjcontroller.dealerCards = [heartTen, heartTen]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .gameoverState)
        XCTAssertTrue(bjcontroller.didDealerWin)
        bjcontroller.gameState = .dealerState
        bjcontroller.dealerCards = [heartTen, heartTwo, heartTwo]
        bjcontroller.updateGameState()
        XCTAssertEqual(bjcontroller.gameState, .dealerState)
        
        // gameover state
        bjcontroller.gameState = .gameoverState
        bjcontroller.dealerCards = [heartTen, heartTwo, heartTwo]
        bjcontroller.playerCards = [heartTwo, heartTwo]
        bjcontroller.updateGameState()
        XCTAssertTrue(bjcontroller.didDealerWin)
        bjcontroller.playerCards = [heartTwo, heartSix, heartTen]
        bjcontroller.updateGameState()
        XCTAssertFalse(bjcontroller.didDealerWin)
        
    }
    
    func test_determineWinner() {
        let seventeen = [heartAce, heartSix]
        let sixteen = [heartTen, heartSix]
        bjcontroller.dealerCards = sixteen
        bjcontroller.playerCards = seventeen
        bjcontroller.determineWinner()
        XCTAssertFalse(bjcontroller.didDealerWin)
        bjcontroller.playerCards = sixteen
        bjcontroller.dealerCards = seventeen
        bjcontroller.determineWinner()
        XCTAssertTrue(bjcontroller.didDealerWin)
        bjcontroller.playerCards = seventeen
        bjcontroller.determineWinner()
        XCTAssertTrue(bjcontroller.didDealerWin)
    }
    
    func test_awardScore() {
        bjcontroller.playerCards = [heartTen, heartAce]
        bjcontroller.awardScore()
        XCTAssertEqual(bjcontroller.playerScore, 71)
        bjcontroller.playerCards = [heartTen, heartTen]
        bjcontroller.dealerCards = [heartTwo, heartTwo]
        bjcontroller.didDealerWin = false
        bjcontroller.playerScore = 0
        bjcontroller.scoreMultiplier = 1
        bjcontroller.awardScore()
        XCTAssertEqual(bjcontroller.playerScore, 16)
        bjcontroller.playerCards = [heartTwo, heartTwo, heartTwo, heartTwo, heartTwo]
        bjcontroller.playerScore = 0
        bjcontroller.awardScore()
        XCTAssertEqual(bjcontroller.playerScore, 56)
        bjcontroller.dealerCards = [heartTwo, heartTen]
        bjcontroller.playerScore = 0
        bjcontroller.didDealerWin = true
        bjcontroller.awardScore()
        XCTAssertEqual(bjcontroller.playerScore, -2)
    }
    
}
