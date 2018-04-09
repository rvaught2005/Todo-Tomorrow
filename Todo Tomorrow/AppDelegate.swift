//
//  AppDelegate.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/8/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Called when your app gets loaded up. Takes place before view did load.
        print("didFinishLaunchingWithOptions")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        // Example of printing the value of user defaults to a .plist file.
        
        // It looks like this in the debug console:
        //Users/ryanvaught/Library/Developer/CoreSimulator/Devices/AF68CA77-ECE9-4E93-98E0-1EA8A5E7A913/data/Containers/Data/Application/1B460EEA-49E5-4EBF-849A-5DCE5D4711C2/Documents
        
        // This file is not easy to find. Probably hidden.
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       // This method is called, for example, when someone gets a phone call while filling out a form.
        print("applicationDidEnterBackground")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       // This happens when the app disapears from the screen.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the app is terminated.
        print("applicationWillTerminate")
    }


}

