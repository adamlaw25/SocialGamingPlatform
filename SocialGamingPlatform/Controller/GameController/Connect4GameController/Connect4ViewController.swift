//
//  Connect4ViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class Connect4ViewController: UIViewController {
    
    var game_controller : Connect4GameController
    
    var image_board : [[UIImageView]]

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var ColBtn1: UIButton!
    
    @IBOutlet weak var ColBtn2: UIButton!
    
    @IBOutlet weak var ColBtn3: UIButton!
    
    @IBOutlet weak var ColBtn4: UIButton!
    
    @IBOutlet weak var ColBtn5: UIButton!
    
    @IBOutlet weak var ColBtn6: UIButton!
    
    @IBOutlet var Row1: [UIImageView]!
    
    @IBOutlet var Row2: [UIImageView]!
    
    @IBOutlet var Row3: [UIImageView]!
    
    @IBOutlet var Row4: [UIImageView]!
    
    @IBOutlet var Row5: [UIImageView]!
    
    @IBOutlet var Row6: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: 0"
        image_board.append(Row1)
        image_board.append(Row2)
        image_board.append(Row3)
        image_board.append(Row4)
        image_board.append(Row5)
        image_board.append(Row6)
        restartGame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.game_controller = Connect4GameController()
        self.image_board = [[UIImageView]]()
        super.init(coder: aDecoder)
        let aSelector : Selector = #selector(Connect4ViewController.handleNotificationGameDidEnd(_: ))
        NotificationCenter.default.addObserver(self, selector: aSelector, name: NSNotification.Name(rawValue: "Connect4 Game Over"), object: game_controller)
    }
    
    //a function to trigger the gameover notification
    @objc func handleNotificationGameDidEnd(_ notification: Notification) {
        if let userInfo = notification.userInfo{
            if let computerWin = userInfo["didComputerWin"]{
                let message = (computerWin as! Bool) ? "Computer Won" : "You Won"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Play again", style: .default, handler: ({(_: UIAlertAction) -> Void in self.restartGame()}))
                scoreLabel.text = "Score: " + String(game_controller.score)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func restartGame() {
        game_controller.resetGame()
        renderImages()
    }
    
    func renderImages() {
        for row in 0...5 {
            for column in 0...5 {
                switch game_controller.game_board[row][column] {
                case 0:
                    image_board[row][column].image = UIImage(named: "grey_circle.png")
                    break
                case 1:
                    image_board[row][column].image = UIImage(named: "red_circle.png")
                    break
                case 2:
                    image_board[row][column].image = UIImage(named: "yellow_circle.png")
                    break
                default:
                    image_board[row][column].image = UIImage(named: "grey_circle.png")
                    break
                }
            }
        }
    }
    
    
    @IBAction func dropAtCol1(_ sender: UIButton) {
        game_controller.dropPuck(column: 0)
        renderImages()
        game_controller.updateGameState()
    }
    
    @IBAction func dropAtCol2(_ sender: UIButton) {
        game_controller.dropPuck(column: 1)
        renderImages()
        game_controller.updateGameState()
    }
    
    @IBAction func dropAtCol3(_ sender: UIButton) {
        game_controller.dropPuck(column: 2)
        renderImages()
        game_controller.updateGameState()
    }
    
    @IBAction func dropAtCol4(_ sender: UIButton) {
        game_controller.dropPuck(column: 3)
        renderImages()
        game_controller.updateGameState()
    }
    
    @IBAction func dropAtCol5(_ sender: UIButton) {
        game_controller.dropPuck(column: 4)
        renderImages()
        game_controller.updateGameState()
    }
    
    @IBAction func dropAtCol6(_ sender: UIButton) {
        game_controller.dropPuck(column: 5)
        renderImages()
        game_controller.updateGameState()
    }

    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    
    

}
