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
            name: "Restaurants",
            cityName: "Espoo",
            coordinates: CLLocationCoordinate2D(latitude: 60.22494, longitude: 24.75979),
            imageNames: ["kebu"],
            description: "Best KEBAB in the whole Wallah veli",
            address: "Kantelettarentie 1 Kauppakeskus Kaari, Helsinki 00420 Finland"
        )
    ]
}
