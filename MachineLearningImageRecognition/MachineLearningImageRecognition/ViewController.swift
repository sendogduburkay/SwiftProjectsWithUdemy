//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Muhammed Burkay Şendoğdu on 17.08.2022.
//

import UIKit
import CoreML
import Vision
class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var chosenImage = CIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeButtonClicked(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        dismiss(animated: true)
        imageView.image = image
        if let ciImage = CIImage(image: image){
            chosenImage = ciImage
        }
        recognizerImage(image: chosenImage)
    }
    
    func recognizerImage(image: CIImage){
        
        if let model = try? VNCoreMLModel(for: MobileNetV2().model){
            let request = VNCoreMLRequest(model: model) { vnrequest, error in
                if let results = vnrequest.results as? [VNClassificationObservation]{
                    let topResult = results.first
                    
                    DispatchQueue.main.async {
                        let condifenceLevel = (topResult?.confidence ?? 0) * 100
                        let rounded = Int( condifenceLevel * 100) / 100
                        self.resultLabel.text = "\(rounded)% it's \(topResult!.identifier)"
                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do{
                    try handler.perform([request])
                }catch{
                    print("error")
                }
            }
        }
    }
    
}

