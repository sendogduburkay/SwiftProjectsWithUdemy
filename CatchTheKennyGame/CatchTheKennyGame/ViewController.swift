//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    
    @IBOutlet var kenny2: UIImageView!
    @IBOutlet var kenny1: UIImageView!
    @IBOutlet var kenny3: UIImageView!
    @IBOutlet var kenny4: UIImageView!
    @IBOutlet var kenny5: UIImageView!
    @IBOutlet var kenny6: UIImageView!
    @IBOutlet var kenny7: UIImageView!
    @IBOutlet var kenny8: UIImageView!
    @IBOutlet var kenny9: UIImageView!
    
    var kennyArray = [UIImageView]()
    var counter = 10{
        didSet{
            timeLabel.text = "\(counter)"
        }
    }
    var timer = Timer()
    var hideTimer = Timer()
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard.object(forKey: "highScore")
        
        if let newScore = defaults as? Int{
            highScoreLabel.text = "Highscore: \(newScore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    @objc func hideKenny(){
        for kennyArray in kennyArray {
            kennyArray.isHidden = true
        }
        
        let random = Int.random(in: 0...8)
        kennyArray[random].isHidden = false
    }
    
    @objc func countDown(){
        
        counter -= 1
      
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if score > highScore{
                highScore = score
                highScoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
            
            let ac = UIAlertController(title: "Time's Up!", message: "Do you wanna play again?", preferredStyle: .alert)
            ac.addAction((UIAlertAction(title: "OK", style: .default)))
            ac.addAction(UIAlertAction(title: "Reply", style: .default, handler: { UIAlertAction in
                self.score = 0
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)

            }))
            present(ac,animated: true)
        }
    }
    
    @objc func increaseScore(){
        score += 1
    }

}

