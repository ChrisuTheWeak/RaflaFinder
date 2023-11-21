//
//  ContentView.swift
//  RafFinder
//
//  Created by iosdev on 11.11.2023.
//

import SwiftUI


struct ContentView: View {
    @State private var userInput: String = ""
    var url = "https://www.kotipizza.fi/menu"
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
                
                Link("To the restaurant menu", destination: URL(string: url)!)
                    
            }
            .offset(y:0)
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        
    }
}
struct CantentView_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
