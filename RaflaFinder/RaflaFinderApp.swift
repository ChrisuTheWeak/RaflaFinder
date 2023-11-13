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
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var body: some Scene {
        WindowGroup {
            ContentView()
            //gays
        }
    }
}
