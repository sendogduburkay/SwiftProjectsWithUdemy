//
//  FeedVC.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutClicked))
    }
    
    
    @objc func logoutClicked(){
        PFUser.logOutInBackground { error in
            if error == nil{
                self.performSegue(withIdentifier: "toSignIn", sender: nil)
            }
        }
    }
}
