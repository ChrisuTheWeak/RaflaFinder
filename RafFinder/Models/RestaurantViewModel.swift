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
        self.updateMapRegion(locations: initialLocations.first!)
        
        // Fetch data from API and Convert address to a coordinate to be displayed on map annotation, is a bit scuffed since getting the coordinate data was not as easy as intended.
        Task {
            do {
                let restaurants = try await APIManager.shared.fetchRestaurants()
                var apiLocations: [Location] = []
                
                for restaurant in restaurants {
                    var location = Location(
                        name: restaurant.name,
                        cityName: restaurant.addressObj.city,
                        coordinates: CLLocationCoordinate2D(),
                        imageNames: [],
                        description: "",
                        address: restaurant.addressObj.addressString
                    )
                    
                    apiLocations.append(location)
                    
                    getCoordinates(from: location.address) { coordinates in
                        if let coordinates = coordinates {
                            location.changeCoord(coordinates)
                            print("Coordinates found for:", location)
                            
                            if let index = apiLocations.firstIndex(where: { $0.id == location.id }) {
                                apiLocations[index] = location
                                self.updateLocations(apiLocations)
                            }
                        } else {
                            print("Failed to get coordinates for:", location)
                        }
                    }
                }
            } catch {
                print("Error fetching restaurants: (error)")
            }
        }

       }

    func updateLocations(_ updatedLocations: [Location]) {
            DispatchQueue.main.async {
                self.locations = updatedLocations
            }
        }
       private func updateMapRegion(locations: Location) {
           withAnimation(.easeInOut) {
               mapRegion = MKCoordinateRegion(center: locations.coordinates, span: mapSpan)
           }
       }

       func toggleRestaurants() {
           withAnimation(.easeInOut) {
               showRestourants = !showRestourants
           }
       }
    //Shows next location for restaurant using above things
       func showNext(location: Location) {
           withAnimation(.easeInOut) {
               mapLocation = location
               updateMapRegion(locations: mapLocation)
               showRestourants = false
           }
       }
    //Converts Address to coordinates for map annotations
    func getCoordinates(from address: String, completion: @escaping(_ coordinates: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let coordinates = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(coordinates)
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
