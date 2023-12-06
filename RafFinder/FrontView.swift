import SwiftUI

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
    @StateObject private var speechRecognizer = SpeechRecognizer()

    var toMapViewButton: String = "Let's Go"

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

                    Spacer(minLength: 0)

                    Image("logoImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 16)
                        .frame(height: 300)

                    Spacer(minLength: 80)

                    TextField("Enter food name", text: $userInput)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.blue)
                        .frame(height: 100)
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Start transcribing when the microphone button is tapped
                                    speechRecognizer.startTranscribing()
                                }) {
                                    Image(systemName: "mic.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding(.trailing, 50)
                            }
                        )

                    Spacer()

                    Button(action: {
                        changeLanguage()
                    }) {
                        Text("Change language")
                            .fontWeight(.heavy)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(40)
                            .padding(.horizontal, 16)
                    }

                    NavigationLink(destination: {
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
            }
            .padding(.bottom, 80)
            .background(Color.white)
            .environmentObject(speechRecognizer)
        }
    }
}

