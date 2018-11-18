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
            self.level.text = String((value?["level"] as? Int)!)
            self.score.text = String((value?["score"] as? Int)!)
            let powerup = (value?["powerup"] as? NSDictionary)!
            self.multiplier.text = String((powerup["multiplier"] as? Int)!)
            self.timeLimit.text = String((powerup["timeLimit"] as? Int)!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
