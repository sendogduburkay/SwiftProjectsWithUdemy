//
//  DetailViewController.swift
//  LandMarkBook
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedImage = selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
        // Do any additional setup after loading the view.
    }

}
