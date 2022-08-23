//
//  ViewController.swift
//  CurrencyConverterProject
//
//  Created by Muhammed Burkay Şendoğdu on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cadLabel: UILabel!
    @IBOutlet var tryLabel: UILabel!
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var jpyLabel: UILabel!
    @IBOutlet var gbpLabel: UILabel!
    @IBOutlet var chfLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesTapped(_ sender: Any) {
//        1) Request & Session => İstemciye ( API adresine istek at.
//        2) Response & Data => Request sonucunda bir yanıt gelecek. Yanıtta Data olacak.
//        3) Parse & JSON Serialization Gelen datayı işlemek işidir.
//        1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=efe89d314404e8699609280e956050fd")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                ac.addAction((UIAlertAction(title: "OK", style: .default)))
                self.present(ac,animated: true)
                
            }
            else{
//                2
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
//                        3
                        DispatchQueue.main.async { [self] in
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                if let CAD = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(CAD)"
                                }
                                if let CHF = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(CHF)"
                                }
                                if let GBP = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(GBP)"
                                }
                                if let JPY = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(JPY)"
                                }
                                if let USD = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(USD)"
                                }
                                if let TRY = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(TRY)"
                                }
                                
                            }
                        }
                    }catch{
                            print("#FFFFFF")
                    }
                
                }
            }
        }
        task.resume() /* Yukarıdakilerin başlatılması için gerekiyor.*/
    }
}

