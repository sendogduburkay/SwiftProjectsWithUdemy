//
//  FeedCell.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet var postImage: UIImageView!
    
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var postuuidLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postuuidLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likedButtonClicked(_ sender: Any) {
    }
    @IBOutlet var commentButtonClicked: NSLayoutConstraint!
    
}
