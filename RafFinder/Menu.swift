//
//  Menu.swift
//  RafFinder


import SwiftUI

struct Menu: View {
    @EnvironmentObject private var vm: RestaurantsViewModel
    let location: Location
    
    @State private var userInput: String = ""
    
    
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
                    Text(location.name)
                        .bold()
                        .fontWeight(.light)
                        .font(.title)
                        .frame(minWidth: 300, minHeight: 80)
                        .padding(.bottom)
                        .background(Color.white)
                        .cornerRadius(20)
                    HStack {
                        backButton
                            .frame(minWidth: 50, minHeight: 50)
                            .background(Color.orange)
                            .cornerRadius(10)
                        
                        Text("Menu")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                            .padding(.bottom)
                            .frame(width: 300, height: 50, alignment: .center)
                            .background(Color.orange)
                            .cornerRadius(10)
                        
                    }
                    .padding(1)
                    
                    
                   /* Link("To the restaurant menu", destination: URL(string: location.webSite)!)
                        .frame(width: 350, height: 400)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .font(.title2) */
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
        Menu(location:
            LocationData.locations.first!)
        .padding()
        .environmentObject(RestaurantsViewModel())
    }
}

extension Menu {
    private var backButton: some View{
        Button{
            vm.sheetMenu = nil
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding()
        }
    }
}
