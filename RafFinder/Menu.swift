//
//  Menu.swift
//  RafFinder
//
//  Created by iosdev on 19.11.2023.
//

import SwiftUI


struct Menu: View {
    @State private var userInput: String = ""
    var restaurantName = "restaurant name"
    var url = "https://www.kotipizza.fi/menu" //needs to be changed cant be hard coded page
    var body: some View {
        NavigationView {
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
                    
                    Text(restaurantName)
                        .bold()
                        .fontWeight(.light)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .padding(.bottom)
                        .background(Color.white)
                        .cornerRadius(20)
                    Text("Menu")
                        .font(.title2)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                        .padding(.bottom)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                    Link("To the restaurant menu", destination: URL(string: url)!)
                        .frame(width: 350, height: 400)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .offset(y:0)
                .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
                .background(Color.red)
            }
        }
    }
}
struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
