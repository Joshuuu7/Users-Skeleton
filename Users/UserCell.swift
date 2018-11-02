//
//  UserCell.swift
//  Users
//
//  Created by Joshua Aaron Flores Stavedahl on 10/31/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
