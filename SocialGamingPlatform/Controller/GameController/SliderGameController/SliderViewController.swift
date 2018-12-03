//
//  SliderViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/15/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    
    
    @IBOutlet weak var score_label: UILabel!
    
    @IBOutlet weak var moves_label: UILabel!
    
    @IBOutlet var Row1: [UIImageView]!
    
    @IBOutlet var Row2: [UIImageView]!
    
    @IBOutlet var Row3: [UIImageView]!
    
    var board : [[UIImageView]]
    
    var game_controller : SliderGameController
    
    @IBOutlet var instructions_label: [UILabel]!
    
    
    required init?(coder aDecoder: NSCoder) {
        self.board = [[UIImageView]]()
        self.game_controller = SliderGameController()
        super.init(coder: aDecoder)
        let aSelector : Selector = #selector(Connect4ViewController.handleNotificationGameDidEnd(_: ))
        NotificationCenter.default.addObserver(self, selector: aSelector, name: NSNotification.Name(rawValue: "Slider Game Over"), object: game_controller)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score_label.text = "Score: 0"
        moves_label.text = "Moves: 0"
        for label in instructions_label {
            label.isHidden = true
        }
        self.initializeSwipeGestures()
        board.append(Row1)
        board.append(Row2)
        board.append(Row3)
        restartGame()
    }
    
    //a function to trigger the gameover notification
    @objc func handleNotificationGameDidEnd(_ notification: Notification) {
        if let userInfo = notification.userInfo{
            if let numOfMoves = userInfo["numOfMoves"] {
                let message = "You have completed the puzzle with \(numOfMoves) moves! \nPlay again?"
                let alert = UIAlertController(title: "Congratz!", message: message, preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Sure, why not?", style: .default, handler: ({(_: UIAlertAction) -> Void in self.restartGame()}))
                let quitAction = UIAlertAction(title: "Nah, I'm outtie", style: .default, handler: ({(_: UIAlertAction) -> Void in self.quitGame()}))
                score_label.text = "Score: " + String(game_controller.score)
                alert.addAction(restartAction)
                alert.addAction(quitAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func initializeSwipeGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeResponse(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeResponse(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeResponse(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeResponse(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeResponse(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                game_controller.move(direction: "UP")
                renderImages()
                game_controller.updateGameState()
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                game_controller.move(direction: "DOWN")
                renderImages()
                game_controller.updateGameState()
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                game_controller.move(direction: "LEFT")
                renderImages()
                game_controller.updateGameState()
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                game_controller.move(direction: "RIGHT")
                renderImages()
                game_controller.updateGameState()
            default:
                break
        }
        updateMoves()
    }
    
    private func restartGame() {
        game_controller.resetGame()
        updateMoves()
        renderImages()
    }
    
    private func updateMoves() {
        moves_label.text = "Moves: \(game_controller.numOfMoves)"
    }

    private func renderImages() {
        for row in 0...2 {
            for column in 0...2 {
                self.board[row][column].image = UIImage(named: "tile_\(game_controller.board[row][column]).png")
            }
        }
    }
    
    
    @IBAction func instructions(_ sender: UIButton) {
        for label in instructions_label {
            label.isHidden = !label.isHidden
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        UpdateAccount.increaseScore(increase: game_controller.score)
        quitGame()
    }
    
    private func quitGame() {
        dismiss(animated: true, completion: nil)
    }
    
}
