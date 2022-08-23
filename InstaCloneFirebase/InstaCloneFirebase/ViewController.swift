//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Muhammed Burkay Şendoğdu on 11.08.2022.
//
import FirebaseAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseStorage
import UIKit


class ViewController: UIViewController {
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional sesitup after loading the view.

    }

    @IBAction func signInClicked(_ sender: Any) { /* Kullanıcı girişi */
        if let email = emailText.text, let password = passwordText.text{
            if !email.isEmpty || !password.isEmpty{
                Auth.auth().signIn(withEmail: email, password: password) { (authdata, error) in
                    if error != nil{
                        self.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error in sign up")
                    }else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
            }
        }else{
            showAlert(title: "Error", message: "Please enter Email/Password!")
        }
        
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) { /* Kullanıcı oluşturma Firebase*/
        
        if let email = emailText.text, let password = passwordText.text{
            if !email.isEmpty || !password.isEmpty{
                Auth.auth().createUser(withEmail: email, password: password) { (authdata, error) in
                    if error != nil{
                        self.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error in sign up")
                    }else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
            }
            else{
                showAlert(title: "Error", message: "Please enter Email/Password!")
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
   
    
    
    
}

