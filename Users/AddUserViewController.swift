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
    //var addedUser: User?
    var addedUser: AddUserData?
    let uploader = Downloader()
    let downloader = Downloader()
    
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
            let user = AddedUser(name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", job: avatarUrlTextField.text! )//lastName: lastNameTextField.text!, avatar: avatarUrlTextField.text!)
            
            // Encode user to JSON like this:
            do {
                let data = try JSONEncoder().encode(user)
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
                let task = URLSession.shared.uploadTask(with: request, from: data) {
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
                            print("Success: User uploaded")
                            let decoder = JSONDecoder()
                            guard let addedUserDecoder = try? decoder.decode(AddUserData.self, from: data!) else {
                                print("Failed")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Success", message: "\n\n New User: \(addedUserDecoder.name) created at: \(addedUserDecoder.createdAt) with ID: \( addedUserDecoder.id)", preferredStyle: .alert)
                                
                                // Resource: https://iosdevcenters.blogspot.com/2016/05/hacking-uialertcontroller-in-swift.html
                                let backView = alert.view.subviews.last?.subviews.last
                                backView?.layer.cornerRadius = 10.0
                                backView?.backgroundColor = UIColor.green
                                
                                let successString = "Success"
                                var myMutableString = NSMutableAttributedString()
                                myMutableString = NSMutableAttributedString(string: successString as String, attributes: [NSAttributedStringKey.font: UIFont(name: "Georgia", size: 18.0)!])
                                myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.cyan, range: NSRange(location:0,length: successString.count))
                                alert.setValue(myMutableString, forKey: "attributedTitle")
                                
                                let message  = "\n\n New User: \(addedUserDecoder.name) created at: \(addedUserDecoder.createdAt) with ID: \( addedUserDecoder.id)"
                                var messageMutableString = NSMutableAttributedString()
                                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedStringKey.font: UIFont(name: "Georgia", size: 14.0)!])
                                messageMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:message.count))
                                alert.setValue(messageMutableString, forKey: "attributedMessage")
                                
                                
                                weakSelf?.present(alert, animated: true, completion: nil)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                                    alert.dismiss(animated: true, completion: nil)
                                })
                            }
                            
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
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        avatarUrlTextField.text = ""
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
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

