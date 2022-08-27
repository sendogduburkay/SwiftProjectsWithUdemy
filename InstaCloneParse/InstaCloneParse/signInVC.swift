//
//  ViewController.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 26.08.2022.
//

import UIKit
import Parse

class signInVC: UIViewController {
    @IBOutlet var usernameText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Send data
        let parseObj = PFObject(className: "Fruits")
        parseObj["name"] = "Banana"
        parseObj["calories"] = 100
        parseObj.saveInBackground { success, error in
            if error != nil{
                print("\(error?.localizedDescription)")
            }else{
                print("saved")
            }
        } */
         /* get data
        let query = PFQuery(className: "Fruits").whereKey("name", equalTo: "Banana")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print("\(error?.localizedDescription)")
            }else{
                if let objects = objects{
                    for object in objects{
                        print("\(object.object(forKey: "name"))")
                    }
                }
            }
        }*/
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
}

