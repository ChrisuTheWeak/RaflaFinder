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
    @StateObject private var vm = RestaurantsViewModel()
    private let manager = CLLocationManager()
    init() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    var body: some Scene {
        
       WindowGroup {
           
           //FrontView()
           //Menu()
           RestaurantView()
               .environmentObject(vm)
       }
    }
}
