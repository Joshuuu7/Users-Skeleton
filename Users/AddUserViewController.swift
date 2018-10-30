//
//  AddUserViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UITextFieldDelegate {

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
 
    // MARK: - AddUserViewController methods
    
    @IBAction func saveUser(_ sender: Any) {
        
        // Make sure text fields are not empty
        
        // Create User object from text field text
        
        // Encode user to JSON like this:
        // let jsonData = try JSONEncoder().encode(user)
        
        // Try to upload jsonData
        
        // If response code is not 201, print error to console
        
        // Else, display "user created" message in alert
    }

    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
