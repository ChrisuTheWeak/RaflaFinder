//
//  LocationData.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import Foundation
import MapKit

class LocationData {
    
    
    
    static let locations: [Location] = [
        Location(
            name: "Start Your Adventure",
            cityName: "Espoo",
            coordinates: CLLocationCoordinate2D(latitude: 60.22494, longitude: 24.75979),
            imageNames: ["kebu"],
            description: "start location",
            address: ""
        ),
        Location(
            name: "Jukka Bar&Kebab",
            cityName: "Espoo",
            coordinates: CLLocationCoordinate2D(),
            imageNames: ["pizza"],
            description: "Suomalainen kala elukka",
            address: ""
        )
    ]
}

    

        
