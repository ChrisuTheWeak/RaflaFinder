import SwiftUI
import CoreLocation
import Speech

class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var currentCity: String?
    private var locationManager = CLLocationManager()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.current)!
    private var recognitionTask: SFSpeechRecognitionTask?

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
        guard let location = locations.first?.coordinate else { return }
        userLocation = location
        print("Location updated: \(location.latitude), \(location.longitude)")

        updateCityName()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }

    func updateCityName() {
        if let location = userLocation {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: location.latitude, longitude: location.longitude)

            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocode failed with error: \(error.localizedDescription)")
                    return
                }

                if let city = placemarks?.first?.locality {
                    self.currentCity = city
                    self.objectWillChange.send()
                }
            }
        }
    }

    func startSpeechRecognition() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session error: \(error.localizedDescription)")
        }

        let request = SFSpeechAudioBufferRecognitionRequest()

        recognitionTask = speechRecognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                let transcribedText = result.bestTranscription.formattedString
                print("Speech Recognition Result: \(transcribedText)")
            }

            if let error = error {
                print("Speech Recognition Error: \(error.localizedDescription)")
            }
        }
    }

    func stopSpeechRecognition() {
        recognitionTask?.cancel()
    }
}

struct FrontPageView: View {
    @State private var userInput: String = ""
    @ObservedObject private var locationManagerDelegate = LocationManagerDelegate()

    @State private var isNavigationActive = false

    var body: some View {
        NavigationView {
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

                    Image("Image")
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
                        isNavigationActive.toggle()
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

                NavigationLink(
                    destination: HomeView(),
                    isActive: $isNavigationActive,
                    label: {
                        EmptyView()
                    }
                )
            }
            .padding(.bottom, 80)
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}


