//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class ViewController: UIViewController {
    var boolean = true
    var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "Yennefer")
        imageView.frame = CGRect(x: view.frame.width / 2 - 200, y: view.frame.height / 2 - 300, width: 400, height: 600)
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changeImage(){
        
        if boolean{
            imageView.image = UIImage(named: "Vesemir")
            boolean = false
        }
        else{
            
                imageView.image = UIImage(named: "Yennefer")
                boolean = true
        }
        
    }

}

