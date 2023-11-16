//
//  ContentView.swift
//  RafFinder
//
//  Created by iosdev on 15.11.2023.
//  Semen Morozov


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            FrontScreenView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FrontScreenView: View {
    @State private var userInput: String = ""

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

                Spacer(minLength: 0)

                Image("logoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 16)
                    .frame(height: 300)

                Spacer(minLength: 80)

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
                           
                            }) {
                                Image(systemName: "mic.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 50)
                        }
                    )

                Spacer()

                Button(action: {
                
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

