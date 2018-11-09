//
//  AddUserViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UITextFieldDelegate {

    var users = [User]()
    let uploader = Downloader()
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var avatarUrlTextField: UITextField!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - AddUserViewController methods
    
    @IBAction func saveUser(_ sender: Any) {
        
        // Make sure text fields are not empty
         weak var weakSelf = self
        if (firstNameTextField.text! != "" && lastNameTextField.text! != "") {
            //&& avatarUrlTextField.text! != "") {
            // Create User object from text field text
            let user = User(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, avatar: avatarUrlTextField.text!)
            
            // Encode user to JSON like this:
            do {
                let jsonData = try JSONEncoder().encode(user)
                //let user = try JSONDecoder().decode(UserData.self, from: jsonData)
                 //weakSelf!.users = user.append(jsonData)
                guard let url = URL(string: "https://reqres.in/api/users") else {
                    // Perform some error handling
                    print("Invalid URL string")
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                // Try to upload jsonData
                let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
                    (data, response, error) in
                    let httpResponse = response as? HTTPURLResponse
                    // If response code is not 201, print error to console
                    if httpResponse!.statusCode != 201 {
                        // Perform some error handling
                        DispatchQueue.main.async {
                            print("HTTP Error: status code \(httpResponse!.statusCode).")
                        }
                    } else if (data == nil && error != nil) {
                        // Perform some error handling
                        DispatchQueue.main.async {
                            print("No data uploaded for \(user).")
                        }
                        // Else, display "user created" message in alert
                    } else {
                        // Download succeeded, decode the JSON data and
                        // display success alert
                        DispatchQueue.main.async {
                            print("Success: user uploaded")
                            let alert = UIAlertController(title: "Success!", message: "\n User added", preferredStyle: .alert)
                            
                            self.present(alert, animated: true, completion: nil)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                                alert.dismiss(animated: true, completion: nil)
                            })
                        }
                    }
                }
                task.resume()
            } catch {
                presentAlert(title: "Error", message: "Unable to encode new user as JSON data")
                print("Error: Unable to encode new user as JSON data")
            }
        } else {
            DispatchQueue.main.async {
                print("Error: user NOT uploaded")
                let alert = UIAlertController(title: "Error!", message: "\n User not added. \n\n Please enter valid text on all fields.", preferredStyle: .alert)
                
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertWithoutButton(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            alertController.dismiss(animated: true, completion: nil)
        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
