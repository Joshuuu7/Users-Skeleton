//
//  DeleteUserViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class DeleteUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let downloader = Downloader()
    var deletedUser: DeletedUser?
    var deletedUserData = [DeletedUserData]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var idPickerView: UIPickerView!
 
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - DeleteUserViewController methods
    
    @IBAction func userSelected(_ sender: UIButton) {
        // Get the selected row of the picker view
        // Try to delete the user with the selected id
        // If response code was not 204, print error to console
        // Else, display "user deleted" alert
        
        // Get the selected row of the picker view
        self.idPickerView.delegate = self
        let selectedId = idPickerView.selectedRow(inComponent: 0) + 1
        let id = selectedId
        weak var weakSelf = self
        
        let user = DeletedUser(id: "\(id)")
        
        let usersURL = "https://reqres.in/api/users/" + "\(id)"
        
        
        guard let url = URL(string: usersURL) else {
            // Perform some error handling
            print("Invalid URL string")
            return
        }
        do {
            let decodedUser = try JSONEncoder().encode(user.self)
            //weakSelf!.user = decodedUser
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Try to upload jsonData
            let task = URLSession.shared.uploadTask(with: request, from: decodedUser){
                (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                // If response code is not 201, print error to console
                if httpResponse!.statusCode != 204 {
                    // Perform some error handling
                    DispatchQueue.main.async {
                        print("HTTP Error: status code \(httpResponse!.statusCode).")
                    }
                } else if (data == nil && error != nil) {
                    // Perform some error handling
                    DispatchQueue.main.async {
                        print("No data deleted for User \(id).")
                    }
                }
                else {
                    print("Success: User deleted")
                    self.presentAlert(title: "Success", message: "User deleted with ID \(id)")
                }
            }
            task.resume()
        } catch {
            weakSelf!.presentAlert(title: "Error", message: "User Not deleted.")
            print("User not deleted")
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
