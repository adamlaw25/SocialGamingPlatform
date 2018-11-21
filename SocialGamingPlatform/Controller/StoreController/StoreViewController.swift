//
//  StoreViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

class StoreViewController: UITableViewController {
    var store = Store()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference(withPath: "users/\(uid!)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let gameList = (value?["gameList"] as? [String])!
            for game in gameList {
                for item in self.store.items {
                    if (game == item.name) {
                        self.store.remove(item: item)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if user wants to edit a member
        if segue.identifier == "to_item_detail" {
            let itemDetailViewController = segue.destination as! StoreDetailViewController
            itemDetailViewController.storeItem = store.items[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath)
        cell.textLabel!.text = store.items[indexPath.row].name + " \n" + String(store.items[indexPath.row].price)
        return cell
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

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
