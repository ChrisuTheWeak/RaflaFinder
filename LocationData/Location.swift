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
    let coordinates: CLLocationCoordinate2D
    let imageNames: [String]
    let description: String
    let address: String
    //let locationId: String
    //let Name: String
    
    
    //identiteetti kaikille listassa oleville.
    var id: String{
        name + cityName
    }
    
    //Converts Address to coordinates for map annotations
    func getCoordinates(from address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let coordinate = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(coordinate)
        }
    }
    
   getCoordinates(from: address) { coordinate in
        if (coordinate != nil){
            print(coordinate.unsafelyUnwrapped)
        }else{
            print("Address Broken!!!")
        }
    }
   

    // lisää lokaatioille logiican millä voi tarkistaa locaation id.n
    static func == (lhs:Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
    
}
