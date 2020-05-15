//
//  AppDelegate.swift
//  PaktolusSolutionsTest
//
//  Created by apple on 14/05/20.
//  Copyright © 2020 snehalata. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    var backgroundTaskTimer:Timer! = Timer()
    let timeInterval = 180

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    func applicationDidEnterBackground(_ application: UIApplication) {

       //Start the background fetch
        self.doBackgroundTask()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

        if self.backgroundTaskTimer != nil {
            self.backgroundTaskTimer.invalidate()
            self.backgroundTaskTimer = nil
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PaktolusSolutionsTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func doBackgroundTask() {
        DispatchQueue.global(qos: .default).async {
            self.beginBackgroundTask()

            if self.backgroundTaskTimer != nil {
                self.backgroundTaskTimer.invalidate()
                self.backgroundTaskTimer = nil
            }

            self.backgroundTaskTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.startTracking), userInfo: nil, repeats: true)
            RunLoop.current.add(self.backgroundTaskTimer, forMode: RunLoop.Mode.default)
            RunLoop.current.run()

            self.endBackgroundTask()

        }
    }
    
    @objc func startTracking() {
        LocationManager.SharedManager.startLocationUpdate()
    }

    func beginBackgroundTask() {
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(withName: "Track trip", expirationHandler: {
            self.endBackgroundTask()
        })
    }

    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    }

}

