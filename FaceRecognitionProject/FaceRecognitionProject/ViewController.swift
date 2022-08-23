//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Muhammed Burkay Şendoğdu on 10.08.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInButttonTapped(_ sender: Any) {
        
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                DispatchQueue.main.async {
                    if success == true{
                        self.performSegue(withIdentifier: "toVC", sender: nil)
                    }
                    else{
                        self.infoLabel.text = "Error!"
                    }
                }

            }
            
            
        }
        
        
        
        
    }
    

}

