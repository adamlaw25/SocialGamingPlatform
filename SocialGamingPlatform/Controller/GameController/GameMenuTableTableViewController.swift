//
//  GameMenuTableTableViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class GameMenuTableTableViewController: UITableViewController {
    
    var game : [String] = ["BlackJack"]

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if user wants to edit a member
        if segue.identifier == "toBJMenu" {
            let indexPath = tableView.indexPathForSelectedRow
            let menuVC = segue.destination as! BJMenuViewController
        }
    }
}
