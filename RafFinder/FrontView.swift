import SwiftUI
import AVFoundation
import Speech

struct FrontView: View {
    var body: some View {
        NavigationView {
            FrontScreenView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView()
    }
}

struct FrontScreenView: View {
    @EnvironmentObject private var vm: RestaurantsViewModel
    @State private var userInput: String = ""
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var isSwedish: Bool = false // Track the current language

    var toMapViewButton: String {
        return isSwedish ? "Låt oss gå" : "Let's Go" // Change button text based on language
    }

    // Placeholder text based on recording status and language
    var placeholderText: String {
        if isRecording {
            return "Listening..."
        } else {
            return isSwedish ? "Ange matnamn" : "Enter food name"
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Set a fixed spacing between elements
                HStack {
                    Text("Rafla Finder")
                        .font(.title)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .kerning(1.4)
                        .padding()
                        .foregroundColor(.blue)
                }

                Image("logoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 16)
                    .frame(height: 300)

//                TextField
                
                TextField(placeholderText, text: $userInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.white)
                    .frame(height: 100)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                // Use a separate function to handle recording
                                toggleRecording()
                            }) {
                                Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 50)
                            // Increase the hit test area for the button
                            .contentShape(Rectangle())
                            .onTapGesture {
                                toggleRecording()
                            }
                        }
                    )

                    .onChange(of: speechRecognizer.transcript) { newValue in
                        // Update userInput when transcript changes
                        userInput = newValue
                    }
                


                Button(action: {
                    changeLanguage()
                }) {
                    Text(isSwedish ? "Byt språk" : "Change language") // Display different text based on the current language
                        .fontWeight(.heavy)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                }

                NavigationLink(destination: {
                    // destination view
                    RestaurantView()
                        .environmentObject(RestaurantsViewModel())
                }, label: {
                    Text(toMapViewButton)
                        .fontWeight(.heavy)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                })
            }
            .padding(.bottom, 50)
            .background(Color.white)
            .environmentObject(speechRecognizer)
        }
    }

    // Add a separate function to handle recording toggle
    func toggleRecording() {
        if isRecording {
            speechRecognizer.stopTranscribing()
        } else {
            speechRecognizer.startTranscribing()
        }
        isRecording.toggle()
    }

    // language toggle function
    func changeLanguage() {
        isSwedish.toggle() // Toggle the language between English and Swedish
        print("Language changed to \(isSwedish ? "Swedish" : "English")")
    }
}

