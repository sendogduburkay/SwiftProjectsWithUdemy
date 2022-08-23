//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Muhammed Burkay Şendoğdu on 19.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseAnalytics
import FirebaseFirestore

class SignInVC: UIViewController {
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text{
            if !email.isEmpty && !password.isEmpty{
                Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
                    if error != nil{
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text, let username = usernameText.text {
            if !email.isEmpty && !username.isEmpty && !password.isEmpty{
                Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
                    if error != nil{
                        self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                    }
                    /*Username'i veritabanına kaydediyoruz. UserInfo collectionunda email ve username olarak 2 verili tutacağız. */
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email": email, "username": username] as [String: Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil{
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                        }
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }else{
                makeAlert(title: "Error!", message: "Username/Email/Password ?")
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "OK", style: .default)))
        present(ac,animated: true)
    }
    
}

