//
//  GameMenuTableTableViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase

class GameMenuTableTableViewController: UITableViewController {
    
    var gameList : [String] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference(withPath: "users/\(uid!)")
        reloadGameList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadGameList()
    }
    
    func reloadGameList() {
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.gameList = (value?["gameList"] as? [String])!
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        cell.textLabel!.text = gameList[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(gameList[indexPath.row].lowercased()).png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let selected_game = gameList[indexPath.row].lowercased()
        let segue_name = "to_\(selected_game)_menu"
        self.performSegue(withIdentifier: segue_name, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if user wants to edit a member
        if segue.identifier == "toBJMenu" {
            let indexPath = tableView.indexPathForSelectedRow
            let menuVC = segue.destination as! BJMenuViewController
        }
        else if segue.identifier == "toConnect4Menu" {
            let indexPath = tableView.indexPathForSelectedRow
            let menuVC = segue.destination as! Connect4MenuViewController
        }
    }
}
