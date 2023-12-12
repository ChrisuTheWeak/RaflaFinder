//
//  FrontView.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//


import SwiftUI
import AVFoundation
import Speech

// Main view for the application
struct FrontView: View {
    
    var body: some View {
        //Embed the FrontScreenView in a NavigationView
        NavigationView {
            FrontScreenView()
                .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview for FrontView
        FrontView()
    }
}

// Front screen of the application
struct FrontScreenView: View {
    @State private var isNavigationActive = false
    @State private var userInput: String = ""
    @FocusState private var isSearchBarFocused: Bool
    @State private var isRecording = false
    @State private var isSwedish: Bool = false // Track the current language
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @Environment(\.managedObjectContext) private var managedObjectContext //The managed object context is used for fetching, modifying, and saving data in Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchHistory.searchText, ascending: true)],
        animation: .default)
    private var searchHistories: FetchedResults<SearchHistory> //This property performs a fetch request in Core Data for 'SearchHistory' entities.
    @StateObject private var languageManager = LanguageManager.shared
    
    
    var placeholderText: String {
            if isRecording {
                return "Listening..."
            } else {
                // placeholder text based on the current language
                return languageManager.currentLanguage == "sv" ? "Ange matnamn" : "Enter food name"
            }
        }
    
    var clbt: String {
        // button text based on the current language
        return languageManager.currentLanguage == "sv" ? "Ändra språk" : "Change Language"
    }
    
    var submit: String {
        // submit button text based on the current language
        return languageManager.currentLanguage == "sv" ? "Skicka in" : "Submit"
    }
    
    // function to save user searches
    private func saveSearch() {
            let searchText = userInput.trimmingCharacters(in: .whitespacesAndNewlines)

            // Check if the search text already exists in the search history or empty
            let alreadyExists = searchHistories.contains { searchHistory in
                searchHistory.searchText?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == searchText.lowercased()
            }

            if !alreadyExists && !searchText.isEmpty {
                let newSearch = SearchHistory(context: managedObjectContext)
                newSearch.searchText = searchText
                print("Attempting to save search: \(searchText)")
                
                do {
                    try managedObjectContext.save()
                    print("Successfully saved search: \(searchText)")
                } catch {
                    print("Error saving context: \(error)")
                }
            } else {
                print("Search text already exists or is empty, not saving: \(searchText)")
            }
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
                    
                    //Get users input from textfield
                    TextField(placeholderText, text: $userInput)
                        .focused($isSearchBarFocused)
                        .onChange(of: isSearchBarFocused){ isFocused in
                            print("Search bar is \(isFocused ? "focused" : "not focused")")
                        }
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.blue)
                        .frame(height: 100)
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Function to handle recording
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
                    
                    // show list of precious searches if searchbar is focused
                    if isSearchBarFocused {
                        
                        List(searchHistories, id: \.self) { searchHistory in
                            Text(searchHistory.searchText ?? "Unknown")
                                .onTapGesture {
                                    userInput = searchHistory.searchText ?? ""
                                    isSearchBarFocused = false  // Unfocus the search bar
                                }
                        }
                        .frame(height: 150)
                        
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
                        //Save user input in searchQuery
                        searchQuery = userInput
                        saveSearch()
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
                        languageManager.changeLanguage()
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
                .onAppear{
                    //Set the initial language to English when the view appears
                    languageManager.currentLanguage = "en"
                }
                
            }
            .padding(.bottom, 80)
            .background(Color.white)
            .environmentObject(speechRecognizer)
        }
    }
    // Function to handle recording toggle
    func toggleRecording() {
            if isRecording {
                speechRecognizer.stopTranscribing()
            } else {
                speechRecognizer.startTranscribing()
            }
            isRecording.toggle()
        }
    // Function to change language
    func changeLanguage(){
        isSwedish.toggle() //Toggle the language between English and Swedish
        print("Language changed to \(isSwedish ? "Swedish" : "English")")
    }
    
}

