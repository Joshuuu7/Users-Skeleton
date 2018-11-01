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
    var downloader = Downloader()
    
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
        weak var weakSelf = self
        
        downloader.downloadData(urlString: "https://reqres.in/") {
            (data) in
            
            guard let jsonData = data else {
                weakSelf!.presentAlert(title: "Error", message: "Unable to download JSON data")
                return
            }
            
            do {
                let user = try JSONDecoder().decode(UserData.self, from: jsonData)
                weakSelf!.users = user.data
                //weakSelf!.tableView.reloadData()
            } catch {
                weakSelf!.presentAlert(title: "Error", message: "Invalid JSON downloaded")
            }
        }
        
        // add objects to array, reload table view
        //users.append(users)
        tableView.reloadData()
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
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
