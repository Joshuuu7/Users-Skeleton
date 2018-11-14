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
    //let userMeta : [UserMeta]
    //let addedUserData: AddUserData
}

struct AddedUser: Codable {
    
    let name: String
    let job: String
}

struct AddUserData: Codable {
    let name: String
    let job: String
    let id: String
    let createdAt: String
    
}

struct SingleUserData: Decodable {
    let data: User
    //let userMeta : [UserMeta]
}

struct UserMeta: Codable {
    let total : String
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
    }
}

struct User: Codable {
    let firstName: String
    let lastName: String
    let avatar: String
    //let userMeta: UserMeta
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar 
        //case userMeta =  "UserMeta"
    }
}

// Create structures to describe JSON responses

extension User {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        //self.userMeta = try container.decode(UserMeta.self, forKey: .userMeta)
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.firstName, forKey: .firstName)
            try container.encode(self.lastName, forKey: .lastName)
            try container.encode(self.avatar, forKey: .avatar)
            //try container.encode(self.userMeta, forKey: .userMeta)
        }
    }
}

/*extension AddUserData {
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.job = try container.decode(String.self, forKey: .job)
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.job, forKey: .job)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.createdAt, forKey: .createdAt)
        }
    }
}*/

extension UserMeta {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(String.self, forKey: .total)
        
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.total, forKey: .total)
            
        }
    }
}

/*extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}*/
