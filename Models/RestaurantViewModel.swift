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
    // Tämän hetkinen sijainti
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //restaurants list
    @Published var showRestourants: Bool = false
    
    //Show location menu
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
        //haetaan tämän hetkinen indexsi locaatiosta.
        guard let currentIndex = locations.firstIndex (where: {$0 == mapLocation}) else{
            print("Didnt find current location")
            return
        }
        //check if NextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            //Next Index is NOT valis
            // restarts from 0
            guard let firstLocation = locations.first else { return }
            showNext(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNext(location: nextLocation)
    }
}
