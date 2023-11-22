//
//  Location.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import Foundation
import MapKit


struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let imageNames: [String]
    let description: String
    
    //identiteetti kaikille listassa oleville.
    var id: String{
        name + cityName
    }
    // lisää lokaatioille logiican millä voi tarkistaa locaation id.n
    static func == (lhs:Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
    
}
