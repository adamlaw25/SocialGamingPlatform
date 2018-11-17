//
//  StoreDetailViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Luo on 11/17/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class StoreDetailViewController: UIViewController {
    var storeItem: StoreItem?
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var detail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detail.isEditable = false
        detail.isSelectable = false
        navigation.title = (storeItem?.name)!
        price.text = String((storeItem?.price)!)
        detail.text = String((storeItem?.detail)!)
    }
    
    @IBAction func buyItem(_ sender: Any) {
        let alert = UIAlertController(title: "price: " + String((storeItem?.price)!), message: "Are you sure to buy?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler:  { (action) -> Void in
            self.goback()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goback() {
        navigationController?.popViewController(animated: true)
    }
    
}
