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
    var userMeta = [UserMeta]()
    var downloader = Downloader()
    
    var firstName = ""
    var lastName = ""
    var image: UIImage?
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateTable()
        //let count = users.count
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
                controller.downloader = downloader
            }
        }
    }
    
    // MARK: - UserListViewController methods
    
    func populateTable() {
        
        // Download data for all users, decode JSON,
        weak var weakSelf = self
        
        //for userMeta in 1...4 {

            downloader.downloadData(urlString: "https://reqres.in/api/users?page=" + "\(userMeta)") {
                (data) in
                
                guard let jsonData = data else {
                    weakSelf!.presentAlert(title: "Error", message: "Unable to download JSON data")
                    return
                }
                do {
                    let decodedUser = try JSONDecoder().decode(UserData.self, from: jsonData)
                    weakSelf!.users = decodedUser.data
                    //let decodedUser = try JSONDecoder().decode(UserData.self, from: jsonData)
                    //weakSelf!.userMeta = decodedUser.userMeta
                    //weakSelf!.userMeta.append(contains(users as! UIFocusEnvironment))
                } catch {
                    weakSelf!.presentAlert(title: "Error", message: "Invalid JSON downloaded")
                }
                //self.users.append(user)
                self.tableView.reloadData()
                print(self.users)
            }
            // add objects to array, reload table view
            //users.append(users)
            //tableView.reloadData()
        //}
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as! UserCell

        // Configure the cell...
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.lastName), \(user.firstName)"
 
        downloader.downloadImage(urlString: user.avatar) {
            (image: UIImage?) in
            cell.avatarImageView!.image = image
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
