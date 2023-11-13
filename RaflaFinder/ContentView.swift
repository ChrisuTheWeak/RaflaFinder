//
//  ContentView.swift
//  RaflaFinder
//
//  Created by iosdev on 9.11.2023.
//

import SwiftUI
import MapKit
import CoreLocation


struct ContentView: View {
    let locationManager = CLLocationManager()
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow)
        ).edgesIgnoringSafeArea(.all)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
