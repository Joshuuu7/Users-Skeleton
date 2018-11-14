//
//  GetSingleUserViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class GetSingleUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //var users = [User]()
    var user: User?
    var downloader = Downloader()
    
    // MARK: - Outlets
    
    @IBOutlet weak var idPickerView: UIPickerView!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Detail" {
            let controller = segue.destination as! DetailViewController
            // Set properties of controller as needed to pass objects
            controller.detailItem = user
            controller.downloader = downloader
            //self.idPickerView = self.idPickerView.dataSource as! UIPickerView
        }
    }

    // MARK: - GetSingleUserViewController methods
    
    @IBAction func userSelected(_ sender: UIButton) {
        
        weak var weakSelf = self
        
        // Else if response code was not 200, print error to console

        // Get the selected row of the picker view.
        self.idPickerView.delegate = self
        let selectedId = idPickerView.selectedRow(inComponent: 0) + 1
        let id = selectedId
    
        // Try to download the data for the user with the selected id
        let usersURL = "https://reqres.in/api/users/" + "\(id)"
    
        downloader.downloadData(urlString: usersURL) {
            (data) in
            
            // If response code was 404, display "user not found" alert
            guard let jsonData = data else {
                weakSelf!.presentAlert(title: "Error", message: "User NOT found.")
                return
            }
            do {
                // Else, decode JSON and manually call
                let decodedUser = try JSONDecoder().decode(SingleUserData.self, from: jsonData)
                weakSelf!.user = decodedUser.data
                weakSelf!.performSegue(withIdentifier: "Show Detail", sender: weakSelf!)
                //weakSelf!.users.append(decodedUser.data)
            } catch {
                weakSelf!.presentAlert(title: "Error", message: "Invalid JSON downloaded")
            }
            //self.users.append(id)
            //self.idPickerView = self.idPickerView.dataSource as! UIPickerView
            //self.performSegue(withIdentifier: "Show Detail", sender: self.idPickerView)
        }
    }

    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }

}
