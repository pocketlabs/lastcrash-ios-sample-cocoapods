//
//  AppDelegate.swift
//  LastCrashSample
//
//  Created by Kyle Shank on 1/9/24.
//

import Foundation
import UIKit
import LastCrash

class AppDelegate: NSObject, UIApplicationDelegate, LastCrashReportSenderDelegate  {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        LastCrash.configure("8c1ebdd74fd64190b41ddd93e8e3ec48")
        LastCrash.enabledLogging()
        LastCrash.setCrashReportSenderDelegate(self)
        LastCrash.applicationInitialized()
        
        return true
    }
    
    func lastCrashReportSenderHandleCrash() {
        print("Sending crash!")
        LastCrash.sendCrashes()
    }
}
