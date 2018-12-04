//
//  BJGameController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation
import UIKit

//GameController class for BlackJack game
class BJGameController {
    var cards = [Card]()
    var playerCards = [Card]()
    var dealerCards = [Card]()
    var gameState: BJGameState
    let maxPlayerCards = 5
    var didDealerWin: Bool
    var playerScore: Int = 0
    var scoreMultiplier: Int = 1
    
    init() {
        self.gameState = .playerState
        self.didDealerWin = false
    }
    
    //reset the game
    func resetGame() {
        cards = Card.generateCards()
        cards.shuffle()
        playerCards = [Card]()
        dealerCards = [Card]()
        gameState = .playerState
    }
    
    // distribute the next card to dealer
    func nextDealerCard() -> Card {
        let card = cards.removeFirst()
        dealerCards.append(card)
        return card
    }
    
    // distribute the next card to player
    func nextPlayerCard() -> Card {
        let card = cards.removeFirst()
        playerCards.append(card)
        return card
    }
    
    // retrieve the delear's card at index
    func dealerCardAt(index: Int) -> Card? {
        if index < dealerCards.count{
            return dealerCards[index]
        }
        else{
            return nil
        }
    }
    
    // retrieve the player's card at index
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
        return playerCards.count == 2 && ((playerCards[0].isAce() && playerCards[1].isValueTen()) || (playerCards[0].isValueTen() && playerCards[1].isAce()))
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
        switch gameState {
        case .playerState:
            if isBlackJack() {
                updateToGameover(didDealerWin: false)
            }
            else if areCardsOver21(playerCards) {
                updateToGameover(didDealerWin: true)
            }
            else if playerCards.count == maxPlayerCards {
                gameState = .dealerState
            }
            break
        case .dealerState:
            if areCardsOver21(dealerCards) {
                updateToGameover(didDealerWin: false)
            }
            else if dealerCards.count == maxPlayerCards {
                gameState = .gameoverState
                gameoverDetermineWinner()
            }
            else {
                let dealerScore = calculateBestScore(dealerCards)
                if dealerScore >= 17 {
                    let playerScore = calculateBestScore(playerCards)
                    if playerScore <= dealerScore {
                        updateToGameover(didDealerWin: true)
                    }
                }
            }
            break
        case .gameoverState:
            gameoverDetermineWinner()
            break
        }
    }
    
    // determine the current winner
    func determineWinner() {
        let dealerScore = calculateBestScore(dealerCards)
        let playerScore = calculateBestScore(playerCards)
        didDealerWin = dealerScore >= playerScore
    }
    
    // update the game state to gameover
    private func updateToGameover(didDealerWin: Bool) {
        gameState = .gameoverState
        self.didDealerWin = didDealerWin
        awardScore()
        gameoverNotification()
    }
    
    // determine winner when gameover
    private func gameoverDetermineWinner() {
        determineWinner()
        awardScore()
        gameoverNotification()
    }
    
    // calculate the award score
    func awardScore() {
        if isBlackJack() {
            playerScore += 50
        }
        if !didDealerWin {
            if(playerCards.count == 5) {
                playerScore += 50
            }
            playerScore += (calculateBestScore(playerCards) - calculateBestScore(dealerCards)) * scoreMultiplier
        }
        else {
            playerScore -= calculateBestScore(dealerCards) - calculateBestScore(playerCards)
        }
        if playerScore < 0 {
            playerScore = 0
        }
    }
}

//enum to represent different game state
enum BJGameState: Int {
    case playerState = 0, dealerState, gameoverState
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
