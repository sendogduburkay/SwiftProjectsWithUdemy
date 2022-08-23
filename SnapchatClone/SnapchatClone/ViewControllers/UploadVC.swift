//
//  UploadVC.swift
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

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker,animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else{ return }
        dismiss(animated: true)
        uploadImageView.image = image
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
//        Storage
        
        let mediaFolder = Storage.storage().reference().child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let uploadImageRef = mediaFolder.child("\(uuid).jpg")
            
            uploadImageRef.putData(data, metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    return self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                  }
            
            uploadImageRef.downloadURL { (url, error) in
                if error == nil{
                        let imageURL = url?.absoluteString
//                    FIRESTORE
                    
                    Firestore.firestore().collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { (snapshot, error) in
                        if error != nil{
                            self.makeAlert(title: "error", message: error?.localizedDescription ?? "error")
                        }
                        if let snapshot = snapshot {
                            if !snapshot.isEmpty{
                                for document in snapshot.documents{
                                    let documentId = document.documentID
                                    if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                        imageUrlArray.append(imageURL!)
                                        let additionalDictionary = ["imageUrlArray" : imageUrlArray] as [String: Any]
                                        /* merge => Mevcut dataları tut ve üzerine yaz.*/
                                        Firestore.firestore().collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { error in
                                            if error == nil{
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(named: "")
                                            }
                                        }
                                    }
                                }
                            }else{
                                let snapDictionary = ["imageUrlArray" : [imageURL!], "snapOwner": UserSingleton.sharedUserInfo.username,
                                                          "date": FieldValue.serverTimestamp() ] as! [String: Any]
                                    
                                Firestore.firestore().collection("Snaps").addDocument(data: snapDictionary) { error in
                                        if error != nil{
                                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                        }else{
                                            self.tabBarController?.selectedIndex = 0
                                            self.uploadImageView.image = UIImage(named: "")
                                        }
                                }

                            }
                        }
                                                        
                    }
                    
                }
            }
        }
    }
}
    
    func makeAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "OK", style: .default)))
        present(ac,animated: true)
    }
    
}
