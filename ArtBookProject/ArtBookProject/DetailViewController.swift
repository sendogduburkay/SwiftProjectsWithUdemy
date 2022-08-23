//
//  DetailViewController.swift
//  ArtBookProject
//
//  Created by Muhammed Burkay Şendoğdu on 8.08.2022.
//
import CoreData
import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var artistText: UITextField!
    @IBOutlet var yearText: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

        saveButton.isEnabled = false
        
        let gestureRecognizerKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizerKeyboard)
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func fetchData(){
        if !chosenPainting.isEmpty{
            saveButton.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id= %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String{
                        nameText.text = name
                    }
                    if let artist = result.value(forKey: "artist") as? String{
                        artistText.text = artist
                    }
                    if let year = result.value(forKey: "year") as? Int{
                        yearText.text = String(year)
                    }
                    if let image = result.value(forKey: "image") as? Data{
                        imageView.image = UIImage(data: image)
                    }
                }
                
            }catch{
                print("#FFFFFFFFF")
                
            }
        }

    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        imageView.backgroundColor = .clear
        saveButton.isEnabled = true
        self.dismiss(animated: true)
        
        imageView.image = image
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        if yearText.text!.isEmpty || artistText.text!.isEmpty || nameText.text!.isEmpty{
            let ac = UIAlertController(title: "Warning!", message: "Please fill the informations!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac,animated: true)
        }else{
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newPaitings = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
            
            newPaitings.setValue(UUID(), forKey: "id")
            newPaitings.setValue(nameText.text, forKey: "name")
            newPaitings.setValue(artistText.text, forKey: "artist")
            
            if let year = Int(yearText.text!) {
                newPaitings.setValue(year, forKey: "year") }
            
            if let image = imageView.image?.jpegData(compressionQuality: 0.8){
                newPaitings.setValue(image, forKey: "image")
            }
            
            do{
                try context.save()
            }catch{
                print("#FFFFFF")
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendNewData"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
    
}

