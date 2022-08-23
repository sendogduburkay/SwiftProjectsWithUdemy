//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Muhammed Burkay Şendoğdu on 13.08.2022.
//

import FirebaseAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseStorage
import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("#FFFF")
        }
    }

}
