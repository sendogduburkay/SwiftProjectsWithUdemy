//
//  UploadVC.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 27.08.2022.
//

import UIKit

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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
