//
//  UserListViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    // MARK: - Properties
    
    var users = [User]()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.detailItem = users[indexPath.row]
                // Pass other objects to controller as needed
            }
        }
    }
    
    // MARK: - UserListViewController methods
    
    func populateTable() {
        
        // Download data for all users, decode JSON,
        // add objects to array, reload table view
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath)

        // Configure the cell...
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.lastName), \(user.firstName)"

        return cell
    }

}
