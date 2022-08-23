//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Muhammed Burkay Şendoğdu on 16.08.2022.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet var passwordText: UITextField!
    @IBOutlet var userNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                                /*       Sınıf tanımlama ve Sınıftan data çağırma       */
//
//        let parseObject = PFObject(className: "Fruits")
//        parseObject["name"] = "Banana"
//        parseObject["calories"] = 150
//        parseObject.saveInBackground { (success, error) in
//            if error != nil{
//                print(error?.localizedDescription)
//            }else{
//                print("success")
//            }
//        }
        
//        let query = PFQuery(className: "Fruits")
//        query.whereKey("calories", lessThan: 120)
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil{
//                print(error?.localizedDescription)
//            }else{
//                print(objects)
//            }
//
//        }
        
        
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if let userName = userNameText.text, let password = passwordText.text{
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
    
    @IBAction func signInClicked(_ sender: Any) {
        if let userName = userNameText.text, let password = passwordText.text{
            if !userName.isEmpty && !password.isEmpty{
                PFUser.logInWithUsername(inBackground: userName, password: password) { (user, error) in
                    if error != nil{
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    }else{
                        self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                        print("welcome")
                    }
                }
            }else{
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

