//
//  StoreDetailViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

class StoreDetailViewController: UIViewController {
    var storeItem: StoreItem?
    var ref: DatabaseReference!
    var gameList: [String]!
    var score: Int!
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var detail: UITextView!
    
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detail.isEditable = false
        detail.isSelectable = false
        navigation.title = (storeItem?.name)!
        price.text = String((storeItem?.price)!)
        detail.text = String((storeItem?.detail)!)
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference(withPath: "users/\(uid!)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.gameList = (value?["gameList"] as? [String])!
            self.score = (value?["score"] as? Int)!
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // action to buy item
    @IBAction func buyItem(_ sender: Any) {
        if score >= (storeItem?.price)! {
            let alert = UIAlertController(title: "price: " + String((storeItem?.price)!), message: "Are you sure to buy?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler:  { (action) -> Void in
                // unlock game
                if self.storeItem?.powerUp == nil {
                    self.unlockGame()
                } else {
                    // buy powerup
                    self.buyPowerup()
                }
                let alert2 = AlertHelper()
                alert2.createAlert(title: "Purchase success!", message: "Thank you! You reamaining score is \(self.score!).", fromController: self)
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = AlertHelper()
            alert.createAlert(title: "Score not enough", message: "Current score(\(score!)) is less than price \((storeItem?.price)!). Go play some more games!", fromController: self)
        }
    }
    
    func unlockGame() {
        self.gameList.append((self.storeItem?.name)!)
        let updateGameList = ["gameList": self.gameList]
        self.ref.updateChildValues(updateGameList as [AnyHashable : Any])
        UpdateAccount.reduceScore(decrease: (storeItem?.price)!)
        self.score -= (storeItem?.price)!
        buyButton.isEnabled = false
    }
    
    func buyPowerup() {
        let powerup = (self.storeItem?.powerUp)!
        let newPowerup = ["powerup": ["multiplier": powerup.multiplier, "timeLimit": powerup.timeLimit]]
        self.ref.updateChildValues(newPowerup)
        UpdateAccount.reduceScore(decrease: (storeItem?.price)!)
        self.score -= (storeItem?.price)!
    }
    
}
