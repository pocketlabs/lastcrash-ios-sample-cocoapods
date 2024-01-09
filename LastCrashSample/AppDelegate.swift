//
//  AppDelegate.swift
//  LastCrashSample
//
//  Created by Kyle Shank on 1/9/24.
//

import Foundation
import UIKit
import LastCrash

class AppDelegate: NSObject, UIApplicationDelegate, LastCrashDelegate  {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        LastCrash.configure("LASTCRASH_API_KEY")
        LastCrash.enabledLogging()
        LastCrash.setDelegate(self)
        
        return true
    }
    
    func lastCrashDidCrash() {
        print("Sending crash!")
        LastCrash.send()
    }
}
