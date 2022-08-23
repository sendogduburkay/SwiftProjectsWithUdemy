//
//  ViewController.swift
//  LandMarkBook
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var landMarkNames = [String]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        if let items = try? fm.contentsOfDirectory(atPath: path){
        
            for item in items {
                if item.hasPrefix("LandMark"){
                landMarkNames.append(item)
                
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            landMarkNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landMarkNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landMarkNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else {return}
        vc.selectedImage = landMarkNames[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


}

