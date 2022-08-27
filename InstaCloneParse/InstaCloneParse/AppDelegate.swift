//
//  AppDelegate.swift
//  InstaCloneParse
//
//  Created by Muhammed Burkay Şendoğdu on 26.08.2022.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "qtQCjSwrz0qkPZFoImJaG4aH9StoSPi4mF1tofyn"
            $0.clientKey = "MJTgzKzF2YVWcJXiMBNyLrINXOp1xyHGQriqNwCK"
            $0.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

