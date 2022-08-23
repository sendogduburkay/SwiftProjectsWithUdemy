//
//  ViewController.swift
//  TheWitcherBook
//
//  Created by Muhammed Burkay Şendoğdu on 7.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var characters = [Characters]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        title = "The Witcher"
        let yen = Characters(name: "Yennefer of Vengerberg", job: "Sorceress", image: UIImage(named: "yennefer")!)
        let geralt = Characters(name: "Geralt", job: "Witcher", image: UIImage(named: "geralt")!)
        let vesemir = Characters(name: "Vesemir", job: "Witcher", image: UIImage(named: "vesemir")!)
        let cirilla = Characters(name: "Cirilla", job: "Unidentifiable", image: UIImage(named: "cirilla")!)
        let dandelion = Characters(name: "Dandelion", job: "Musician", image: UIImage(named: "dandelion")!)
        characters = [yen,geralt,vesemir,cirilla,dandelion]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else {return}
        vc.character = characters[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

