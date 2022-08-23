//
//  SnapVC.swift
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
import ImageSlideshow


class SnapVC: UIViewController {
    @IBOutlet var timeLabel: UILabel!
    var selectedSnap: Snap?
    var inputArray = [KingfisherSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedSnap = selectedSnap {
            timeLabel.text = "Time Left: \(selectedSnap.timeLeft)"
            for imageURL in selectedSnap.imageUrlArray{
                inputArray.append(KingfisherSource(urlString: imageURL)!)
            }
        }
        
        let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: view.frame.height * 0.90))
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .lightGray
        pageIndicator.pageIndicatorTintColor = .black
        imageSlideShow.pageIndicator = pageIndicator
        imageSlideShow.backgroundColor = .white
        imageSlideShow.contentScaleMode = .scaleAspectFit
        imageSlideShow.setImageInputs(inputArray)
        
        
        view.addSubview(imageSlideShow)
        self.view.bringSubviewToFront(timeLabel)
       
    }
}

