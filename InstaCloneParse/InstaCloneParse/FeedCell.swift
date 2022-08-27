//
//  FeedCell.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//
import Parse
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
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()!.username
        likeObject["to"] = postuuidLabel.text
        
        likeObject.saveInBackground { success, error in
            if error != nil{
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true)
            }
        }
    }
    @IBOutlet var commentButtonClicked: NSLayoutConstraint!
    
}
