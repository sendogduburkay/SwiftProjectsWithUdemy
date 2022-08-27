//
//  UploadVC.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentText: UITextField!
    @IBOutlet var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        postButton.isEnabled = false
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        imageView.image = image
        dismiss(animated: true)
        postButton.isEnabled = true
        
    }
    
    @IBAction func postButtonClicked(_ sender: Any) {
        postButton.isEnabled = false
        let object = PFObject(className: "Posts")
        object["postComment"] = commentText.text
        object["postOwner"] = PFUser.current()!.username
        object["postUUID"] = UUID().uuidString
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuidString = UUID().uuidString
            let pfFile = PFFileObject(name: uuidString, data: data)
            object["postImage"] = pfFile
        }
        
        object.saveInBackground { (success, error) in
            if error == nil{
                self.commentText.text = ""
                self.imageView.image = UIImage(named: "image.png")
                self.tabBarController?.selectedIndex = 0
            }else{
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac,animated: true)
            }
        }
    }
    

}
