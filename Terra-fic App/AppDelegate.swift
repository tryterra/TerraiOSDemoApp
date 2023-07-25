//
//  AppDelegate.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 01/04/2023.
//

import Foundation
import UIKit
import TerraiOS

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Terra.setUpBackgroundDelivery() 
        return true
    }
}
