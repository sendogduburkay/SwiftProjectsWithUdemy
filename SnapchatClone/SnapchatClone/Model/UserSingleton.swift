//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Muhammed Burkay Şendoğdu on 19.08.2022.
//

import Foundation

class UserSingleton{
    static let sharedUserInfo = UserSingleton()
    
    var email: String = ""
    var username: String = ""
    
    private init(){
        
    }
    
    
}
