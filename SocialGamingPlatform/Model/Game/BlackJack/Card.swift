//
//  Card.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import UIKit

//Card class to represent a card
class Card {
    var suit: Suit
    var digit: Int
    var isFaceUp = true
    
    init(suit: Suit, digit: Int) {
        self.suit = suit
        self.digit = digit
    }
    
    //static function to generate a deck of cards
    static func generateCards() -> [Card] {
        var deck = [Card]()
        for i in 0..<4 {
            for j in 1...13 {
                deck.append(Card(suit: Suit(rawValue: i)!, digit: j))
            }
        }
        return deck
    }
    
    //retrieve the card images from Assets folder
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

//enum to represent a suit
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
