//
//  StartViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

//a class that represents the starting viewcontroller
class StartViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        email.delegate = self
        password.delegate = self
    }
    
    //a button action that triggers the login
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                print("logggggggg")
                print(Auth.auth().currentUser?.email!)
                self.performSegue(withIdentifier: "startToHome", sender: self)
            }
            else{
                let alert = AlertHelper()
                let warning = error?.localizedDescription
                alert.createAlert(title: "Error", message: warning!, fromController: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "startToHome", sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
