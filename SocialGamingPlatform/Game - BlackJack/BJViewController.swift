//
//  BJViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class BJViewController: UIViewController {
    
    var curPlayerCardIndex = 0
    
    var curDealerCardIndex = 0
    
    @IBOutlet var dealerCards: [UIImageView]!
    
    @IBOutlet var playerCards: [UIImageView]!
    
    private var gameController: BJGameController
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var hitBtn: UIButton!
    
    @IBOutlet weak var standBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: 0"
        restartGame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.gameController = BJGameController()
        super.init(coder: aDecoder)
        let aSelector : Selector = #selector(BJViewController.handleNotificationGameDidEnd(_: ))
        NotificationCenter.default.addObserver(self, selector: aSelector, name: NSNotification.Name(rawValue: "BlackJack Game Over"), object: gameController)
    }
    
    @objc func handleNotificationGameDidEnd(_ notification: Notification) {
        if let userInfo = notification.userInfo{
            if let dealerWin = userInfo["didDealerWin"]{
                let message = (dealerWin as! Bool) ? "Dealer Won" : "You Won"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Play again", style: .default, handler: ({(_: UIAlertAction) -> Void in self.restartGame()}))
                scoreLabel.text = "Score: " + String(gameController.playerScore)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func restartGame() {
        gameController.resetGame()
        curPlayerCardIndex = 0
        curDealerCardIndex = 0
        var card = gameController.nextDealerCard()
        UIImageView.transition(with: dealerCards[curDealerCardIndex], duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        curDealerCardIndex += 1
        card = gameController.nextDealerCard()
        card.isFaceUp = false
        
        
        card = gameController.nextPlayerCard()
        UIImageView.transition(with: playerCards[curPlayerCardIndex], duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        curPlayerCardIndex += 1
        card = gameController.nextPlayerCard()
        UIImageView.transition(with: playerCards[curPlayerCardIndex], duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        curPlayerCardIndex += 1
        renderCards()
        if gameController.isBlackJack() {
            gameController.updateGameState()
        }
        hitBtn.isEnabled = true
        standBtn.isEnabled = true
    }
    
    func renderCards() {
        for i in 0 ..< gameController.maxPlayerCards{
            if let dealerCard = gameController.dealerCardAt(index: i){
                dealerCards[i].image = dealerCard.getCardImage()
                dealerCards[i].isHidden = false
            }else{
                dealerCards[i].isHidden = true
            }
            if let playerCard = gameController.playerCardAt(index: i){
                playerCards[i].image = playerCard.getCardImage()
                playerCards[i].isHidden = false
            }else{
                playerCards[i].isHidden = true
            }
        }
    }
    
    @IBAction func playerHit(_ sender: UIButton) {
        gameController.nextPlayerCard()
        UIImageView.transition(with: playerCards[curPlayerCardIndex], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        curPlayerCardIndex += 1
        renderCards()
        gameController.updateGameState()
    }
    
    @IBAction func playerStand(_ sender: UIButton) {
        gameController.gameState = .dealerState
        playDealerTurn()
    }
    
    
    func playDealerTurn() {
        hitBtn.isEnabled = false
        standBtn.isEnabled = false
        showSecondDealerCard()
    }
    
    func showSecondDealerCard()  {
        if let card = gameController.dealerCardAt(index: 1){
            UIImageView.transition(with: dealerCards[curDealerCardIndex], duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
            curDealerCardIndex += 1
            card.isFaceUp = true
            renderCards()
            gameController.updateGameState()
            if(gameController.gameState != .gameoverState){
                let aSelector : Selector = #selector(BJViewController.showDealerNextCard)
                perform(aSelector, with: nil, afterDelay: 1)
            }
        }
    }
    
    @objc func showDealerNextCard(){
        gameController.nextDealerCard()
        UIImageView.transition(with: dealerCards[curDealerCardIndex], duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        curDealerCardIndex += 1
        renderCards()
        gameController.updateGameState()
        if(gameController.gameState != .gameoverState){
            let aSelector : Selector = #selector(BJViewController.showDealerNextCard)
            perform(aSelector, with: nil, afterDelay: 1)
        }
    }
}
