//
//  FeedVC.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutClicked))
        
        getData()
    }
    
    
    func getData(){
        let query = PFQuery(className: "Posts")
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
            }else{
                if let objects = objects{
                if objects.count > 0{
                    for object in objects{
                        self.postOwnerArray.append(object.object(forKey: "postOwner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postComment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postUUID") as! String)
                        self.postImageArray.append(object.object(forKey: "postImage") as! PFFileObject)
                    }
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postUUIDArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.postuuidLabel.text = postUUIDArray[indexPath.row]
        postImageArray[indexPath.row].getDataInBackground { data, error in
            if error == nil{
                
                cell.postImage.image = UIImage(data: data!)
            }else{
                print("Error in imageview!")
            }
        }
        
        return cell
    }
    
    
    @objc func logoutClicked(){
        PFUser.logOutInBackground { error in
            if error == nil{
                self.performSegue(withIdentifier: "toSignIn", sender: nil)
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
}
