//
//  RestaurantDetailView.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//


import SwiftUI
//useless Screen... NOT IN USE.
struct RestaurantDetailView: View {
    
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20,
                            x:0, y:10)
                VStack(alignment: .leading, spacing: 16){
                    VStack(alignment: .leading, spacing: 8){
                        Text(location.name)
                            .font(.largeTitle)
                        Text(location.cityName)
                    }
                }
            }
            }
            .ignoresSafeArea()
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(location:
            LocationData.locations.first!)
    }
}

extension RestaurantDetailView{
    private var imageSection: some View{
        TabView {
            ForEach(location.imageNames, id: \.self){
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    }
