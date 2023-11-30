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
            name: "jamal Kebab",
            cityName: "Espoo",
            coordinates: CLLocationCoordinate2D(latitude: 60.22494, longitude: 24.75979),
            imageNames: ["kebu"],
            description: "Best KEBAB in the whole Wallah veli",
            webSite: "https://www.kotipizza.fi/menu"
        ),
        Location(
            name: "Jukka Bar&Kebab",
            cityName: "Espoo",
            coordinates: CLLocationCoordinate2D(latitude: 60.27496, longitude: 24.79970),
            imageNames: ["pizza"],
            description: "Suomalainen kala elukka",
            webSite: "https://www.kotipizza.fi/menu"
        )
    ]
}
