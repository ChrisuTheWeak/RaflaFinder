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

       // Map's current Location
       @Published var mapLocation: Location
       @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
       let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

       // Restaurants list for dropdown menu
       @Published var showRestourants: Bool = false

       // Show location menu clicked restaurants menu page.
       @Published var sheetMenu: Location? = nil

       init() {
           // Load initial data from LocationData
           let initialLocations = LocationData.locations
           self.mapLocation = initialLocations.first!
           self.locations = initialLocations
           self.updateMapRegion(location: initialLocations.first!)

           // Fetch data from API
           Task {
               do {
                   let restaurants = try await APIManager.shared.fetchRestaurants()
                   // Convert `Restaurant` to `Location` and update `locations`
                   let apiLocations = restaurants.map { restaurant in
                       Location(name: restaurant.name, cityName: restaurant.addressObj.city, coordinates: CLLocationCoordinate2D(), imageNames: [], description: "", address: restaurant.addressObj.addressString)
                   }
                   DispatchQueue.main.async {
                       self.locations = apiLocations
                   }
               } catch {
                   print("Error fetching restaurants: \(error)")
               }
           }
       }

       private func updateMapRegion(location: Location) {
           withAnimation(.easeInOut) {
               mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
           }
       }

       func toggleRestaurants() {
           withAnimation(.easeInOut) {
               showRestourants = !showRestourants
           }
       }

       func showNext(location: Location) {
           withAnimation(.easeInOut) {
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
