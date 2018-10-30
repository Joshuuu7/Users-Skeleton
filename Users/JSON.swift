//
//  JSON.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let data: [User]
}

struct User: Codable {
    let firstName: String
    let lastName: String
    let avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// Create structures to describe JSON responses

