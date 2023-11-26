import Foundation
import SwiftUI

class FindSearch {
    private let apiKey = "54B590DBD956436CB09843EAFEC982D2"
    
    func fetchTripAdvisorData() {
        // Construct the API URL with the provided query parameters
        let urlString = "https://api.content.tripadvisor.com/api/v1/location/search?API_KEY=\(apiKey)&searchQuery=pizza&category=reastaurants&radius=5&radiusUnit=km&language=en"
        
        if let url = URL(string: urlString) {
            // Create an HTTP request with the constructed URL
            let request = createRequest(url: url)
            
            // Initiate the data fetching process
            fetchData(with: request)
        } else {
            print("Invalid URL")
        }
    }

    // Function to create an HTTP GET request
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set the "accept" header to indicate that we expect JSON data in the response
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        return request
    }

    // Function to initiate data fetching using the provided request
    private func fetchData(with request: URLRequest) {
        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)") // Handle network errors
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                
                if let data = data {
                    // Parse and handle the JSON data in the response
                    self.parseData(data)
                }
            }
        }
        
        
        dataTask.resume()
    }

    // Function to parse the JSON data received from the API
    private func parseData(_ data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Now 'json' is a dictionary containing the parsed JSON data
                print(json)
            }
        } catch {
            print("Error parsing JSON: \(error)") // Handle JSON parsing errors
        }
    }
}
