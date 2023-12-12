//
//  RafFinderApp.swift
//  RafFinder
//
//  Created by iosdev on 15.11.2023.
//

import SwiftUI
import CoreLocation
import CoreData

@main
struct RafFinderApp: App {
    private let manager = CLLocationManager()
    let persistentContainer: NSPersistentContainer
    
    init() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Initialize the persistent container
        persistentContainer = NSPersistentContainer(name: "Model")
        
        // Load the persistent stores
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        }
    }
    var body: some Scene {
        WindowGroup {
            FrontView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
    

