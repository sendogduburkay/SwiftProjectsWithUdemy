//
//  FeedVC.swift
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
import SDWebImage
class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var snapArray = [Snap]()
    let fireStoreDatabase = Firestore.firestore()
    var chosenSnap: Snap?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getSnapsFromFireBase()
        getUserInfo()
        
    }
    
    func getSnapsFromFireBase(){
        /* her değişiklik olduğunda güncelleme yapılmasını istiyoruz*/
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }
            if let snapshot = snapshot {
                if !snapshot.isEmpty{
                    self.snapArray.removeAll()
                    for document in snapshot.documents{
                        let documentId = document.documentID
                        if let username = document.get("snapOwner") as? String{
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp{
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        if difference >= 24{
//                                            Delete
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete()
                                        }
                                        let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue(), timeLeft: 24 - difference)
                                        self.snapArray.append(snap)
                                    }
                                   
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo(){
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser?.email).getDocuments { (snapShot, error) in
            if error != nil{
                self.makeAlert(title: "error", message: error?.localizedDescription ?? "")
            }
            if let snapShot = snapShot {
                if !snapShot.isEmpty{
                    for document in snapShot.documents{
                        if let username = document.get("username") as? String{
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC"{
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = chosenSnap
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    
    
    func makeAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "OK", style: .default)))
        present(ac,animated: true)
    }
}
