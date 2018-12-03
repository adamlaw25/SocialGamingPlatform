//
//  AccountViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var multiplier: UILabel!
    @IBOutlet weak var timeLimit: UILabel!
    var ref: DatabaseReference!
    @IBOutlet weak var levelUpButton: UIButton!
    
    override func viewDidLoad() {
        let uid = Auth.auth().currentUser?.uid
        self.ref = Database.database().reference(withPath: "users/\(uid!)")
        reloadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadInfo()
    }
    
    func reloadInfo() {
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.email.text = (value?["email"] as? String)!
            let levelValue = (value?["level"] as? Int)!
            self.level.text = String(levelValue)
            let scoreValue = (value?["score"] as? Int)!
            self.score.text = String(scoreValue)
            if scoreValue >= levelValue * 1000 {
                self.levelUpButton.isEnabled = true
            } else {
                self.levelUpButton.isEnabled = false
            }
            let powerup = (value?["powerup"] as? NSDictionary)!
            self.multiplier.text = String((powerup["multiplier"] as? Int)!)
            self.timeLimit.text = String((powerup["timeLimit"] as? Int)!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func levelUp(_ sender: Any) {
        let cost = (Int(self.level.text!))! * 1000
        let alert = UIAlertController(title: "Are you sure to level up?", message: "Level up will cost \(String(cost)) points.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler:  { (action) -> Void in
            // level up
            UpdateAccount.reduceScore(decrease: cost)
            UpdateAccount.levelUp()
            let alert2 = AlertHelper()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.reloadInfo()
                alert2.createAlert(title: "Level up success!", message: "Thank you! You reamaining score is \((Int(self.score.text!))! - cost).", fromController: self)
            }
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
