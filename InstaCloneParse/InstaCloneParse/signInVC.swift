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
        if let userName = usernameText.text, let password = passwordText.text{
            if !userName.isEmpty && !password.isEmpty{
                PFUser.logInWithUsername(inBackground: userName, password: password) { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    } else {
                        self.makeAlert(title: "Error", message: error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if let userName = usernameText.text, let password = passwordText.text{
            if !userName.isEmpty && !password.isEmpty{
                let user = PFUser()
                user.username = userName
                user.password = password
                user.signUpInBackground { (success, error) in
                    if error != nil{
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    }else{
                        self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                        print("ok")
                    }
                }
            }
            else{
                makeAlert(title: "Error", message: "Username / Password??")
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
}

