//
//  RestaurantViewModel.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import Foundation
import SwiftUI
import MapKit

class RestaurantsViewModel: ObservableObject{
    //Ladatut paikat
    @Published var locations: [Location]
    
    //Kartan tämänhetkinen sijainti
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    
    //restaurants listed
    @Published var showRestourants: Bool = false
    
    init() {
        let locations = LocationData.locations
        
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    private func updateMapRegion (location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center:location.coordinates,
                span:mapSpan)
        }
    }
    func toggleRestaurants(){
        withAnimation(.easeInOut){
            showRestourants = !showRestourants
        }
    }
    func showNext(location: Location) {
        withAnimation(.easeInOut){
            mapLocation = location
            showRestourants = false
        }
        
    }
}