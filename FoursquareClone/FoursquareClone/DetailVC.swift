//
//  DetailVC.swift
//  FoursquareClone
//
//  Created by Muhammed Burkay Şendoğdu on 16.08.2022.
//
import MapKit
import UIKit
import Parse


class DetailVC: UIViewController,MKMapViewDelegate {
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailNameLabel: UILabel!
    
    @IBOutlet var detailMapView: MKMapView!
    @IBOutlet var detailAtmosphereLabel: UILabel!
    @IBOutlet var detailTypeLabel: UILabel!
    
    var chosenPlaceId = ""
    var chosenPlaceLatitude = Double()
    var chosenPlaceLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailMapView.delegate = self
        
       getDataFromParse()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil{
                
            }else{
                if objects != nil{
                    let chosenPlaceObject = objects![0]
                    if let placeName = chosenPlaceObject.object(forKey: "name") as? String{
                        self.detailNameLabel.text = placeName
                    }
                    if let placeType = chosenPlaceObject.object(forKey: "type") as? String{
                        self.detailTypeLabel.text = placeType
                    }
                    if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String{
                        self.detailAtmosphereLabel.text = placeAtmosphere
                    }
                    
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String{
                        if let placeLatitude = Double(placeLatitude){
                            self.chosenPlaceLatitude = placeLatitude
                        }
                    }
                    if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String{
                        if let placeLongitude = Double(placeLongitude){
                            self.chosenPlaceLongitude = placeLongitude
                        }
                    }
                    
                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground { (data, error) in
                            if error == nil{
                                if data != nil{
                                    self.detailImageView.image =  UIImage(data: data!)
                                }
                            }
                        }
                    }
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenPlaceLatitude, longitude: self.chosenPlaceLongitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailMapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detailNameLabel.text!
                    annotation.subtitle = self.detailTypeLabel.text!
                    self.detailMapView.addAnnotation(annotation)
                    

                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let identifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if chosenPlaceLatitude != 0.0 && chosenPlaceLongitude != 0.0{
            let requestLocation = CLLocation(latitude: chosenPlaceLatitude, longitude: chosenPlaceLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks{
                    if placemark.count > 0{
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
        }
    }

}
