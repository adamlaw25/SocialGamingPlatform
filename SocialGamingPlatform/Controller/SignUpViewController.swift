//
//  SignUpViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

//a class that represents the signup view controller
class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
        passwordConfirm.delegate = self
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let alert = AlertHelper()
        if password.text != passwordConfirm.text{
            alert.createAlert(title: "Password Incorrect", message: "Please re-type password", fromController: self)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    let user = User(email: self.email.text!)
                    let ref = Database.database().reference(withPath: "users")
                    ref.child((Auth.auth().currentUser?.uid)!).setValue(user.toDictionary())
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                }
                else{
                    alert.createAlert(title: "Sign up error", message: "Please confirm your information", fromController: self)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
