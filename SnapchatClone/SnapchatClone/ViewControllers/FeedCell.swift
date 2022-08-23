//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Muhammed Burkay Şendoğdu on 20.08.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet var feedLabel: UILabel!
    @IBOutlet var feedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
