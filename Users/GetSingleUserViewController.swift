//
//  GetSingleUserViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class GetSingleUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

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
        }
    }

    // MARK: - GetSingleUserViewController methods
    
    @IBAction func userSelected(_ sender: UIButton) {
        
        // Get the selected row of the picker view
        
        // Try to download the data for the user with the selected id
        
        // If response code was 404, display "user not found" alert
        
        // Else if response code was not 200, print error to console
        
        // Else, decode JSON and manually call
        // performSegue(withIdentifier: "Show Detail", sender: self)
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
