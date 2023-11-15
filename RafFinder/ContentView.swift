//
//  ContentView.swift
//  RaflaFinder
//
//  Created by iosdev on 11.11.2023.
//

import SwiftUI
import WebKit


struct ContentView: View {
    @State private var userInput: String = ""
    var body: some View {
        ZStack {
            VStack {
                TextField("Enter food or restaurant name", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                    .overlay(
                        HStack{
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image(systemName: "mic.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 50)
                        }
                    )
                
                Text("Restaurant Name Here")
                    .bold()
                    .fontWeight(.light)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                    .padding(.bottom)
                
                Text("Menu")
                    .font(.title2)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                    .padding(.bottom)
                
                Link(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=URL@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/) {
                    Rectangle()
                        .fill(.yellow)
                        .frame(minWidth: 0, maxWidth: 380, minHeight:0)
                }
            }
            .offset(y:0)
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
