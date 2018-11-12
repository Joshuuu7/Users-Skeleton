//
//  MenuViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var tableView: UITableView? = nil
    var users = [User]()
    var downloader = Downloader()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Optional - can be used to pass objects to the other view
    // controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Get Single User" {
            let controller = segue.destination as! GetSingleUserViewController
            // Set properties of controller as needed to pass objects
            controller.downloader = downloader
        } else if segue.identifier == "Get User List" {
            let controller = segue.destination as! UserListViewController
            // Set properties of controller as needed to pass objects
            if let indexPath = tableView?.indexPathForSelectedRow {
                let object = users[indexPath.row]
                
                controller.downloader = downloader
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "Add User" {
            let controller = segue.destination as! AddUserViewController
            // Set properties of controller as needed to pass objects
        } else if segue.identifier == "Delete User" {
            let controller = segue.destination as! DeleteUserViewController
            // Set properties of controller as needed to pass objects
        }
    }
}

