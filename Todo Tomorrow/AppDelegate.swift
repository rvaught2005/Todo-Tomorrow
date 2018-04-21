//
//  AppDelegate.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/8/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Called when your app gets loaded up. Takes place before view did load.
//        print("didFinishLaunchingWithOptions")
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as         String)
        // Example of printing the value of user defaults to a .plist file.
        
        // It looks like this in the debug console:
        //Users/ryanvaught/Library/Developer/CoreSimulator/Devices/AF68CA77-ECE9-4E93-98E0-1EA8A5E7A913/data/Containers/Data/Application/1B460EEA-49E5-4EBF-849A-5DCE5D4711C2/Documents
        
        // This file is not easy to find. Probably hidden.
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        //The name above must match the name of our .xcdatamodeld file.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

