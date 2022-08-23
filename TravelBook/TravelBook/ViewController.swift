//
//  ViewController.swift
//  TravelBook
//
//  Created by Muhammed Burkay Şendoğdu on 8.08.2022.
//

import CoreLocation
import MapKit
import UIKit
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var commentText: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    let locationMenager = CLLocationManager()
    var chosenLocationLongitude:  Double = 0.0
    var chosenLocationLatitude: Double = 0.0
    var selectedTitle = ""
    var selectedTitleID: UUID?
    
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationMenager.delegate = self
        
        locationMenager.desiredAccuracy = kCLLocationAccuracyBest
        locationMenager.requestWhenInUseAuthorization()
        locationMenager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if selectedTitle != ""{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context =  appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            fetchRequest.returnsObjectsAsFaults = false
            let stringID = selectedTitleID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", stringID!)
            
            do{
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String{
                         annotationTitle = title
                        if let subtitle = result.value(forKey: "subtitle") as? String{
                            annotationSubtitle = subtitle
                            if let longitude = result.value(forKey: "longitude") as? Double{
                                annotationLongitude = longitude
                                if let latitude = result.value(forKey: "latitude") as? Double{
                                    annotationLatitude = latitude
                                    let annotation = MKPointAnnotation()
                                    annotation.title = annotationTitle
                                    annotation.subtitle = annotationSubtitle
                                    let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                    annotation.coordinate = coordinate
                                    self.mapView.addAnnotation(annotation)
                                    nameText.text = annotation.title
                                    commentText.text = annotation.subtitle
                                    
                                    locationMenager.stopUpdatingLocation()
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    mapView.setRegion(region, animated: true)
                                    
                                }
                            }
                        }
                    }
                }
                
            }catch{
                print("#FFFFFF")
            }
        }
        
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began /* UIGestureRecognizer.State.began */{
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let touchPointCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            chosenLocationLatitude = touchPointCoordinate.latitude
            chosenLocationLongitude = touchPointCoordinate.longitude
            
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchPointCoordinate
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == ""{
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        }
    }
    /* annotation özelleştirme işi*/
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let identifier = "myAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }
        else{
            annotationView?.annotation = annotation
        }
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedTitle != ""{
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placeMark,error) in
                if let placeMark = placeMark{
                   if placeMark.count > 0{
                       let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                       let item = MKMapItem(placemark: newPlaceMark)
                       item.name = self.selectedTitle
                       let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                       item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(UUID(), forKey: "id")
        newPlace.setValue(chosenLocationLatitude, forKey: "latitude")
        newPlace.setValue(chosenLocationLongitude, forKey: "longitude")
        
        do{
            try context.save()
            print("Success")
        }catch{
            print("#FFFF FAIL")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    

}

