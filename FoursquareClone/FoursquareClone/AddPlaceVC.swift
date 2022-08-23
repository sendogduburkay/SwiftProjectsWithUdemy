//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Muhammed Burkay Şendoğdu on 16.08.2022.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var placeNameText: UITextField!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var placeAtmosphereText: UITextField!
    @IBOutlet var placeTypeText: UITextField!
    @IBOutlet var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton.isHidden = true
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addNewImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func addNewImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        nextButton.isHidden = false
        dismiss(animated: true)
        placeImageView.image = image
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if let placeName = placeNameText.text, let placeType = placeTypeText.text, let placeAtmosphere = placeAtmosphereText.text{
            if !placeName.isEmpty && !placeType.isEmpty && !placeAtmosphere.isEmpty{
                PlaceModel.sharedInstance.placeName = placeName
                PlaceModel.sharedInstance.placeType = placeType
                PlaceModel.sharedInstance.placeAtmosphere = placeAtmosphere
                PlaceModel.sharedInstance.placeImage = placeImageView.image!
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }
            else{
                let ac = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere/Image??", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac,animated: true)
            }
        }
    }
}
