//
//  alertHelper.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//
import UIKit
import Foundation

class AlertHelper {
    func createAlert(title: String, message: String, fromController controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  { (action) -> Void in
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
