//
//  BJGameController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
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

//GameController class for BlackJack game
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
        let card = cards.removeFirst()
        playerCards.append(card)
        return card
    }
    
    func dealerCardAt(index: Int) -> Card? {
        if index < dealerCards.count{
            return dealerCards[index]
        }
        else{
            return nil
        }
    }
    
    func playerCardAt(index: Int) -> Card? {
        if index < playerCards.count{
            return playerCards[index]
        }
        else{
            return nil
        }
    }
    
    //check if the cards are over 21
    func areCardsOver21(_ curCards: [Card]) -> Bool {
        var lowestScore = 0
        for card in curCards {
            if card.isAce() {
                lowestScore += 1
            }
            else if card.isValueTen() {
                lowestScore += 10
            }
            else {
                lowestScore += card.digit
            }
        }
        return lowestScore > 21
    }
    
    //check if the cards are a blackjack combination
    func isBlackJack() -> Bool {
        if playerCards.count == 2 {
            if playerCards[0].isAce() && playerCards[1].isValueTen() {
                return true
            }
            else if playerCards[0].isValueTen() && playerCards[1].isValueTen() {
                return true
            }
        }
        return false
    }
    
    //calculate the best score of a combination of cards
    func calculateBestScore(_ curCards: [Card]) -> Int {
        if areCardsOver21(curCards) {
            return 0
        }
        var highestScore = 0
        for card in curCards {
            if card.isAce() {
                highestScore += 11
            }
            else if card.isValueTen() {
                highestScore += 10
            }
            else {
                highestScore += card.digit
            }
        }
        while highestScore > 21 {
            highestScore -= 10
        }
        return highestScore
    }
    
    //produce a gameover notification
    func gameoverNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "BlackJack Game Over"), object: self, userInfo: ["didDealerWin": didDealerWin])
    }
    
    //update the game state
    func updateGameState() {
        if gameState == .playerState {
            if isBlackJack() {
                gameState = .gameoverState
                didDealerWin = false
                gameoverNotification()
            }
            else if areCardsOver21(playerCards) {
                gameState = .gameoverState
                didDealerWin = true
                //play again somehow
                gameoverNotification()
            }
            else if playerCards.count == maxPlayerCards {
                gameState = .dealerState
            }
        }
        else if gameState == .dealerState {
            if areCardsOver21(dealerCards) {
                gameState = .gameoverState
                didDealerWin = false
                //play again somehow
                gameoverNotification()
            }
            else if dealerCards.count == maxPlayerCards {
                gameState = .gameoverState
                determineWinner()
                //play again somehow
                gameoverNotification()
            }
            else {
                let dealerScore = calculateBestScore(dealerCards)
                if dealerScore < 17 {
                    //do nothing, still dealer's turn
                }
                else {
                    let playerScore = calculateBestScore(playerCards)
                    if playerScore > dealerScore {
                        //do nothing
                    }
                    else {
                        didDealerWin = true
                        gameState = .gameoverState
                        gameoverNotification()
                    }
                }
            }
        }
        else {
            determineWinner()
            gameoverNotification()
        }
    }
    
    func determineWinner() {
        let dealerScore = calculateBestScore(dealerCards)
        let playerScore = calculateBestScore(playerCards)
        didDealerWin = dealerScore >= playerScore
    }
    
    //reset the game
    func resetGame() {
        cards = Card.generateCards()
        cards.shuffle()
        playerCards = [Card]()
        dealerCards = [Card]()
        gameState = .playerState
    }
}

//enum to represent different game state
enum BJGameState: Int {
    case playerState = 0, dealerState, gameoverState
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

//extension method to shuffle an array
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
