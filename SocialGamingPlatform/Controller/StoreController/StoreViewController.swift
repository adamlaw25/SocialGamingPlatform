//
//  StoreViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class StoreViewController: UITableViewController {
    var storelist: Store!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storelist = Store()
        reloadItemList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadItemList()
    }
    
    func reloadItemList() {
        Constants.refs.currentUser.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let gameList = (value?["gameList"] as? [String])!
            for game in gameList {
                for item in self.storelist.items {
                    if (game == item.name) {
                        self.storelist.remove(item: item)
                    }
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storelist.items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_item_detail" {
            let itemDetailViewController = segue.destination as! StoreDetailViewController
            itemDetailViewController.storeItem = storelist.items[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storelist", for: indexPath)
        cell.textLabel!.text = storelist.items[indexPath.row].name + " \n" + String(storelist.items[indexPath.row].price)
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
