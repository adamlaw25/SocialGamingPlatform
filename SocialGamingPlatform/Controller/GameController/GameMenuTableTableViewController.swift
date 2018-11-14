//
//  GameMenuTableTableViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class GameMenuTableTableViewController: UITableViewController {
    
    var game : [String] = ["BlackJack", "Connect4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        cell.textLabel!.text = game[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(game[indexPath.row].lowercased()).png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let selected_game = game[indexPath.row].lowercased()
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
