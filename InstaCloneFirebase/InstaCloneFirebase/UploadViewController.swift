//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Muhammed Burkay Şendoğdu on 13.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentText: UITextField!
    @IBOutlet var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
        imageView.image = image
    }
    /* Kullanıcının seçtiği görseli Storage'a eklediğimiz yer. Image'in URL'sini storage'a aldıktan sonra artık image URL'si ile birlikte yanında kaydedilmesini istediğimiz her şeyi veritabanına alacağız.*/
    @IBAction func saveButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let stringID = UUID().uuidString
            let imageReference = mediaFolder.child("\(stringID).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error save image!")
                }else{
                    /* Image URL'si alınıyor. Database işlemleri başlıyor. */
                    imageReference.downloadURL { (url, error) in
                        if error == nil{
                            let imageURL = url?.absoluteString /* ABSOLUTE STRING YAPMAYINCA NEDEN VERİTABANINA EKLEMİYOR? */
                            
//                            DATABASE
                            let fireStoreDatabase = Firestore.firestore()
                            var fireStoreReference: DocumentReference? = nil
                            let firestorePost = ["imageURL": imageURL!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentText.text!, "date": FieldValue.serverTimestamp(), "likes": 0] as [String : Any]
                            fireStoreReference = fireStoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    self.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error in Database")
                                }
                                else{
                                    self.imageView.image = UIImage(named: "")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    print("successs")
                                }
                                
                            })
                            
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    

}
