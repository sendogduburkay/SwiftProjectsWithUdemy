//
//  MusicianClass.swift
//  AdvancedSwiftProject
//
//  Created by Muhammed Burkay Şendoğdu on 17.08.2022.
//

import Foundation

class MusicianClass{
    
    var name: String
    var age: Int
    var instument: String
    
    init(name: String, age: Int, insturement: String){
        self.name = name
        self.age = age
        self.instument = insturement
    }
    
    
    func happyBirthday(){
        self.age += 1
    }
    
}
