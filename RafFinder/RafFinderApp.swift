//
//  RafFinderApp.swift
//  RafFinder
//
//  Created by iosdev on 15.11.2023.
//

import SwiftUI

@main
struct RafFinderApp: App {
    @StateObject private var vm = RestaurantsViewModel()
       
    var body: some Scene {
       WindowGroup {
           FrontView()
           //Menu()
           //RestaurantView()
              // .environmentObject(vm)
       }
    }
}
