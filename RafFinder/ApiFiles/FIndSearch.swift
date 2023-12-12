import Foundation
import CoreLocation


// Address object model
struct Address: Codable {
    let street1: String
    let city: String
    let country: String
    let postalcode: String
    let addressString: String

    enum CodingKeys: String, CodingKey {
        case street1, city, country, postalcode
        case addressString = "address_string"
    }
    
}

// Restaurant model
struct Restaurant: Codable {
    let locationId: String
    let name: String
    let distance: String
    let bearing: String
    let addressObj: Address

    enum CodingKeys: String, CodingKey {
        case locationId = "location_id"
        case name, distance, bearing
        case addressObj = "address_obj"
    }
}

// Top-level response model
struct ApiResponse: Codable {
    let data: [Restaurant]
}

// API Configuration
let apiKey = "54B590DBD956436CB09843EAFEC982D2"
var searchQuery = ""
var category = "restaurants"
let latLong = "60.2194,24.8135"
let radius = "5"
let radiusUnit = "km"
var language = "en"


//function to perform the API request
func FindSearchApi() {
    let urlString = "https://api.content.tripadvisor.com/api/v1/location/search?key=\(apiKey)&searchQuery=\(searchQuery)&category=\(category)&latLong=\(latLong)&radius=\(radius)&radiusUnit=\(radiusUnit)&language=\(language)"
    if let url = URL(string: urlString) {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        //Create a URLSession data task to fetch data
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }
            //Parse the JSON data
            guard let data = data else {
                print("No data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                // Process your data here
                for restaurant in apiResponse.data {
                    print("Name: \(restaurant.name), Location ID: \(restaurant.locationId), Address: \(restaurant.addressObj.addressString)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        dataTask.resume()
    } else {
        print("Invalid URL")
    }
    
}

//APIManager Class for managing API calls using Swift's async/await syntax
class APIManager {
    static let shared = APIManager()

    func fetchRestaurants() async throws -> [Restaurant] {
        let urlString = "https://api.content.tripadvisor.com/api/v1/location/search?key=\(apiKey)&searchQuery=\(searchQuery)&category=\(category)&latLong=\(latLong)&radius=\(radius)&radiusUnit=\(radiusUnit)&language=\(LanguageManager.shared.currentLanguage)"
    
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        // Perform an async data fetch
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decode the JSON response
        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
        return apiResponse.data
    }
}

