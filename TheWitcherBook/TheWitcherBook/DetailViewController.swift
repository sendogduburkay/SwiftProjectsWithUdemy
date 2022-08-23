//
//  DetailViewController.swift
//  TheWitcherBook
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var character: Characters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            jobLabel.text = character.job
            name.text = character.name
            imageView.image = character.image
        }

        // Do any additional setup after loading the view.
    }
    

}
