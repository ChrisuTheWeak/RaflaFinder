//
//  RestaurantViewModel.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class RestaurantsViewModel: ObservableObject{
    //Loaded  locations from data (LocationData)
    @Published var locations: [Location]
    
    //Map's current Location
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    // Current Location of map and user.
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //restaurants list for dropdown menu
    @Published var showRestourants: Bool = false
    
    //Show location menu clicked restaurants menu page.
    //also check if something is selected and display that and return to first index if list is complete.
    @Published var sheetMenu : Location? = nil
    
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
    
    func nxtButtonPress (){
        //get current index of map.
        guard let currentIndex = locations.firstIndex (where: {$0 == mapLocation}) else{
            print("Didnt find current location")
            return
        }
        //check if NextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            //Next Index is NOT valid
            // restarts from 0
            guard let firstLocation = locations.first else { return }
            showNext(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNext(location: nextLocation)
    }
    

}
