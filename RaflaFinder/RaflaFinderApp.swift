//
//  RaflaFinderApp.swift
//  RaflaFinder
//
//  Created by iosdev on 9.11.2023.
//

import SwiftUI
import MapKit

@main
struct RaflaFinderApp: App {
    
    @StateObject private var vm = RestaurantsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RestaurantView()
                .environmentObject(vm)
        }
    }
}
