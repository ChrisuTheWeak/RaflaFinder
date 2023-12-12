//
//  Location.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import Foundation
import CoreLocation
import MapKit


struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    var coordinates: CLLocationCoordinate2D
    let imageNames: [String]
    let description: String
    let address: String
    
    //let locationId: String
    //let Name: String
    mutating func changeCoord (_ newCord:CLLocationCoordinate2D){
        coordinates = newCord
    }
    
    //Identity to all list items
    var id: String{
        name + cityName
    }

    //Adds logic for locations so that location id can be checked    
    static func == (lhs:Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
    
}
