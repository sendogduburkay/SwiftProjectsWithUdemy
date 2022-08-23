//
//  ViewController.swift
//  TimerProject
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var timeLabel: UILabel!
    var counter = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 200, y: 200, width: 100, height: 50)
        timeLabel.text = "Time: \(counter)"
        view.addSubview(timeLabel)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFunc(){
        
        
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0{
            timeLabel.text = "Finish"
        }
        
    }


}

