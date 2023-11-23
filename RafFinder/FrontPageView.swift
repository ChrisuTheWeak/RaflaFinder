import SwiftUI
import CoreLocation

class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?

    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else {
            return
        }
        userLocation = location
        print("Location updated: \(location.latitude), \(location.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

struct FrontPageView: View {
    @State private var userInput: String = ""
    @ObservedObject private var locationManagerDelegate = LocationManagerDelegate()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Rafla Finder")
                        .font(.title)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .kerning(1.4)
                        .padding()
                        .foregroundColor(.blue)
                }

                if let location = locationManagerDelegate.userLocation {
                    Text("Latitude: \(location.latitude), Longitude: \(location.longitude)")
                        .foregroundColor(.blue)
                        .padding()
                }

                Spacer(minLength: 0)

                Image("logoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 16)
                    .frame(height: 300)

                Spacer(minLength: 40)

                TextField("Enter food or restaurant name", text: $userInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.blue)
                    .frame(height: 100)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                // Handle microphone button action
                            }) {
                                Image(systemName: "mic.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 50)
                        }
                    )

                Spacer()

                Button(action: {
                    // Handle Random button action
                }) {
                    Text("Random")
                        .fontWeight(.heavy)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                }

                Button(action: {
                    // Handle Let's Go button action
                    print("Let's Go button tapped with input: \(userInput)")
                }) {
                    Text("Let's Go")
                        .fontWeight(.heavy)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                }
            }
        }
        .padding(.bottom, 80)
        .background(Color.white)
    }
}

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}

