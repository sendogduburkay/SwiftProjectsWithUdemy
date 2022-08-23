//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Muhammed Burkay Şendoğdu on 16.08.2022.
//

import Foundation
import UIKit

class PlaceModel{
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
    
    
}
