//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by Muhammed Burkay Şendoğdu on 6.08.2022.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var name: UITextField!
    @IBOutlet var birthday: UITextField!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let deleteButton = UIButton()
        deleteButton.frame = CGRect(x: 200, y: 400, width: 100, height: 50)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.tintColor = .red
        deleteButton.backgroundColor = .black
        deleteButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        view.addSubview(deleteButton)
        
        
        if let name = UserDefaults.standard.object(forKey: "name") as? String{
            if let birthday = UserDefaults.standard.object(forKey: "birthday") as? String{
                    nameLabel.text = "Name: \(name)"
                    birthdayLabel.text = "Birthday: \(birthday)"
            }
        }
        
        
    }
    
    @objc func deleteUser(sender: UIButton!){
        print("clicked")
        if let name = UserDefaults.standard.object(forKey: "name") as? String{
            if let birthday = UserDefaults.standard.object(forKey: "birthday") as? String{
                UserDefaults.standard.removeObject(forKey: name)
                UserDefaults.standard.removeObject(forKey: birthday)
                nameLabel.text = "Name: "
                birthdayLabel.text = "Birthday: "

            }
        }
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if let name = name.text {
            if let birthday = birthday.text{
                nameLabel.text = "Name: \(name)"
                birthdayLabel.text = "Birthday: \(birthday)"
                
                defaults.set(name, forKey: "name")
                defaults.set(birthday, forKey: "birthday")
            }
        }
    }
    
}

