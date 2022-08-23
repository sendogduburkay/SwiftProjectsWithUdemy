//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Muhammed Burkay Şendoğdu on 14.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore

class FeedCell: UITableViewCell {
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var documentIdLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            
            let likeStore = ["likes": likeCount + 1] as [String: Any]
            /* merge(Birleştir) şu demek oluyor; Sadece likeStore'da verdiğimi güncelle. FireStore'daki diğer verileri değiştirme demektir. */
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
        
    }
    
}
