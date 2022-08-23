//
//  MusicianStruct.swift
//  AdvancedSwiftProject
//
//  Created by Muhammed Burkay Şendoğdu on 17.08.2022.
//

import Foundation

struct MusicianStruct{
    
    var name: String
    var age: Int
    var instrument: String
    
    mutating func happyBirthday(){
        self.age += 1
    }
    
}
