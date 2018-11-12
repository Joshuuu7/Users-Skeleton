//
//  DetailViewController.swift
//  Users
//
//  Created by Kurt McMahon on 10/10/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var downloader: Downloader?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    // MARK: - Properties
    
    var detailItem: User? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DetailViewController methods
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = avatarImageView {
                // Optional - Download avatar image and assign
                // it to imageView
                downloader?.downloadImage(urlString: detail.avatar) {
                    (image: UIImage?) in
                    self.avatarImageView.image = image
                }
            }
            
            if let label = nameLabel {
                label.text = "\(detail.firstName) \(detail.lastName)"
            }
        }
    }
}
