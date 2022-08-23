//
//  ViewController.swift
//  TravelBookTekrar
//
//  Created by Muhammed Burkay Şendoğdu on 10.08.2022.
//
import CoreData
import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var titleText: UITextField!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var subtitleText: UITextField!
    
    var chosenFromListTitle = ""
    var chosenFromListTitleID = UUID()
    let locationManager = CLLocationManager()
    var firstChosenLongitude: Double = 0.0
    var firstChosenLatitude: Double = 0.0
    
    var chosenAnnotationTitle = ""
    var chosenAnnotationSubtitle = ""
    var chosenAnnotationLongitude = 0.0
    var chosenAnnotationLatitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if chosenFromListTitle != ""{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            fetchRequest.returnsObjectsAsFaults = false
            let idString = chosenFromListTitleID.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            do{
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String{
                        chosenAnnotationTitle = title
                        if let subtitle = result.value(forKey: "subtitle") as? String{
                            chosenAnnotationSubtitle = subtitle
                            if let latitude = result.value(forKey: "latitude") as? Double{
                                chosenAnnotationLatitude = latitude
                                if let longitude = result.value(forKey: "longitude") as? Double{
                                    chosenAnnotationLongitude = longitude
                                    
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = CLLocationCoordinate2D(latitude: chosenAnnotationLatitude, longitude: chosenAnnotationLongitude)
                                    annotation.title = chosenAnnotationTitle
                                    annotation.subtitle = chosenAnnotationSubtitle
                                    mapView.addAnnotation(annotation)
                                    
                                    locationManager.stopUpdatingLocation()
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                                    let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                                    mapView.setRegion(region, animated: true)
                                    
                                }
                            }
                        }
                    }
                }
                    
            }catch{
                print("#FFFFFFF")
            }
            
        }
        
        
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in: mapView)
            let touchPointCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            firstChosenLatitude = touchPointCoordinate.latitude
            firstChosenLongitude = touchPointCoordinate.longitude
            
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchPointCoordinate
            annotation.title = "New Anno"
            annotation.subtitle = "NewAnnotation"
            mapView.addAnnotation(annotation)
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if chosenFromListTitle == ""{
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let identifier = "myAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.tintColor = .purple
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        
        }else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        /* Navigasyon açacağız. Mevcut konumumuzdan, seçip geldiğimiz annotation'a gidiş için bir güzergah çizecek.*/
        if chosenFromListTitle != ""{
            let requestLocation = CLLocation(latitude: chosenAnnotationLatitude, longitude: chosenAnnotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placeMarks,error) in
                if let placeMark = placeMarks{
                   if placeMark.count > 0{
                       let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                       let item = MKMapItem(placemark: newPlaceMark) /* Haritaları açabilmek için bu mapItem classına ihtiyaç duyuyoruz. */
                       item.name = self.chosenFromListTitle
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
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        entity.setValue(titleText.text, forKey: "title")
        entity.setValue(subtitleText.text, forKey: "subtitle")
        entity.setValue(UUID(), forKey: "id")
        entity.setValue(firstChosenLatitude, forKey: "latitude")
        entity.setValue(firstChosenLongitude, forKey: "longitude")
        
        do{
            try context.save()
            print("success")
        }catch{
            print("#FFFFFFF")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
        
        
    }
    

}

