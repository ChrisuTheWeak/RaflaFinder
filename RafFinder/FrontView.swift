//
//  FrontView.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//


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
    @State private var isNavigationActive = false
    @State private var userInput: String = ""
    @State private var isRecording = false
    @State private var isSwedish: Bool = false //Track the current language
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    
    var placeholderText: String {
            if isRecording {
                return "Listening..."
            } else {
                return isSwedish ? "Ange matnamn" : "Enter food name"
            }
        }
    
    var clbt: String {
        return isSwedish ? "Ändra språk" : "Change Language" //Change text based on language
    }
    
    var submit: String {
        return isSwedish ? "Skicka in" : "Submit" //Change text based on language
    }
    
    var body: some View {
        NavigationView{
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
                    
                    TextField(placeholderText, text: $userInput)
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
                                    if isRecording {
                                        speechRecognizer.stopTranscribing()
                                    } else {
                                        speechRecognizer.startTranscribing()
                                    }
                                    isRecording.toggle()
                                }) {
                                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding(.trailing, 50)
                            }
                        )
                        .onChange(of: speechRecognizer.transcript) { newValue in
                            // Update userInput when transcript changes
                            userInput = newValue
                        }
                        .onTapGesture {
                            // Clear the text field when tapped
                            userInput = ""
                        }
                    
                    ZStack{
                        //Navigates to map view using user's search
                        NavigationLink(destination:
                            RestaurantView(), isActive: $isNavigationActive) {
                            EmptyView()
                        }
                        Text("")
                    }
                    .hidden()
                    Button {
                        searchQuery = userInput
                        isNavigationActive = true
                    } label: {
                        Text(submit)
                            .fontWeight(.heavy)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(40)
                            .padding(.horizontal, 16)
                    }
                
                    Spacer()
                    //Button to change language on FrontView
                    Button(action: {
                        changeLanguage()
                    }) {
                        Text(clbt)
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
            .environmentObject(speechRecognizer)
        }
    }
    func changeLanguage(){
        isSwedish.toggle() //Toggle the language between English and Swedish
        print("Language changed to \(isSwedish ? "Swedish" : "English")")
    }
    
}

