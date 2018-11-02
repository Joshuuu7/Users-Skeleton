//
//  Downloader.swift
//  Users
//
//  Created by Joshua Aaron Flores Stavedahl on 10/30/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation
import UIKit

class Downloader {

    func downloadData(urlString: String, completion: @escaping (_ data: Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // Perform some error handling
            print("Invalid URL string")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse!.statusCode != 200 {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("HTTP Error: status code \(httpResponse!.statusCode).")
                    completion(nil)
                }
            } else if (data == nil && error != nil) {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("No data downloaded for \(urlString).")
                    completion(nil)
                }
            } else {
                // Download succeeded, attempt to decode JSON
                DispatchQueue.main.async {
                    print("Success")
                    completion(data)
                }
            }
        }
        task.resume()
    }
    
    
    func uploadData(urlString: String, completion: @escaping (_ data: Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // Perform some error handling
            print("Invalid URL string")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse!.statusCode != 201 {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("HTTP Error: status code \(httpResponse!.statusCode).")
                    completion(nil)
                }
            } else if (data == nil && error != nil) {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("No data uploaded for \(urlString).")
                    completion(nil)
                }
            } else {
                // Download succeeded, attempt to decode JSON
                DispatchQueue.main.async {
                    print("Success, data uploaded")
                    completion(data)
                }
            }
        }
        task.resume()
        
    }
}
