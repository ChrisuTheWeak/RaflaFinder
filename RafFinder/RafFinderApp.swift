//
//  RafFinderApp.swift
//  RafFinder
//
//  Created by iosdev on 15.11.2023.
//

import SwiftUI
import CoreLocation
@main
struct RafFinderApp: App {
    private let manager = CLLocationManager()
    init() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("manager")
        
        
    }
    var body: some Scene {
       WindowGroup {
           FrontView()
       }
    }
}
