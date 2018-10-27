//
//  BJGameController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import UIKit

class Card {
    var suit: Suit
    var digit: Int
    var isFaceUp = true
    
    init(suit: Suit, digit: Int) {
        self.suit = suit
        self.digit = digit
    }
    
    static func generateCards() -> [Card] {
        var deck = [Card]()
        for i in 0..<4 {
            for j in 0...13 {
                deck.append(Card(suit: Suit(rawValue: i)!, digit: j))
            }
        }
        return deck
    }
    
    func getCardImage() -> UIImage? {
        if isFaceUp {
            return UIImage(named: "\(suit.toString())-\(digit).png")
        }
        else {
            return UIImage(named: "card-back.png")
        }
    }
    
    func isAce() -> Bool {
        return digit == 1
    }
    
    func isValueTen() -> Bool {
        return digit > 9
    }
}

class BJGameController {
    private var cards = [Card]()
    private var playerCards = [Card]()
    private var dealerCards = [Card]()
    var gameState: BJGameState
    let maxPlayerCards = 5
    var didDealerWin: Bool
    
    init() {
        self.gameState = .playerState
        self.didDealerWin = false
    }
    
    func nextDealerCard() -> Card {
        let card = cards.removeFirst()
        dealerCards.append(card)
        return card
    }
    
    func nextPlayerCard() -> Card {
        let card = cards. removeFirst()
        playerCards.append(card)
        return card
    }
}

enum BJGameState: Int {
    case playerState = 0, dealerState, gameoverState
}

enum Suit: Int {
    case club = 0, spade, diamond, heart
    func toString() -> String {
        switch self {
        case .club:
            return "club"
        case .spade:
            return "spade"
        case .diamond:
            return "diamond"
        case .heart:
            return "heart"
        }
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0...(self.count - 1) {
            let tmpInt = i + 1
            let j = Int(arc4random_uniform(UInt32(tmpInt)))
            let tmp = self[i]
            self[i] = self[j]
            self[j] = tmp
        }
    }
}
