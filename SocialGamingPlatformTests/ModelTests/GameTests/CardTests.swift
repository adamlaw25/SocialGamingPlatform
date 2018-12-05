//
//  CardTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class CardTests: XCTestCase {
    
    var deck : [Card]!
    
    var diamondAce : Card!
    
    var heartTen : Card!
    
    var clubKing : Card!

    override func setUp() {
        super.setUp()
        deck = Card.generateCards()
        diamondAce = Card(suit: .diamond, digit: 1)
        heartTen = Card(suit: .heart, digit: 10)
        clubKing = Card(suit: .club, digit: 13)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_generateCards() {
        let deck2 = Card.generateCards()
        XCTAssertEqual(deck2.count, 52)
        var numOfClub = 0
        var numOfSpade = 0
        var numOfDiamond = 0
        var numOfHeart = 0
        for card in deck {
            switch card.suit {
            case .club:
                numOfClub += 1
            case .spade:
                numOfSpade += 1
            case .diamond:
                numOfDiamond += 1
            case .heart:
                numOfHeart += 1
            }
        }
        XCTAssertEqual(numOfClub, 13)
        XCTAssertEqual(numOfSpade, 13)
        XCTAssertEqual(numOfDiamond, 13)
        XCTAssertEqual(numOfHeart, 13)
    }
    
    func test_getCardImage() {
        XCTAssertTrue(heartTen.getCardImage()!.isEqual(UIImage(named: "heart-10.png")))
        heartTen.isFaceUp = false
        XCTAssertTrue(heartTen.getCardImage()!.isEqual(UIImage(named: "card-back.png")))
    }
    
    func test_isAce() {
        XCTAssertTrue(diamondAce.isAce())
    }
    
    func test_isValueTen() {
        XCTAssertTrue(heartTen.isValueTen())
        XCTAssertTrue(clubKing.isValueTen())
    }

}
