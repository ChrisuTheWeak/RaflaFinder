//
//  RestaurantPreview.swift
//  RafFinder
//
//  Created by iosdev on 24.11.2023.
//

import SwiftUI


// Preview for restaurant: show name city. 3 buttons Directions, Menu and Nxt Button. LocationData is used here to and RVM to localize data on screen for what will be shown.
struct RestaurantPreview: View {
    
    @ObservedObject var vm: RestaurantsViewModel
    let location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 5) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageCard
                textCard
            }
            VStack{
                directionsButton
                menuButton
                nxtRaflaButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:45)
        )
        .cornerRadius(10)
        
    }
}

/*struct RestaurantPreview_Previews: PreviewProvider {
    @ObservedObject var vm: RestaurantsViewModel
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            RestaurantPreview(vm: <#RestaurantsViewModel#>, location:
                LocationData.locations.first!)
            .padding()
        }
    }
}*/
    extension RestaurantPreview {
        //Restaurants picture
        private var imageCard: some View{
            ZStack{
                if let imageName = location.imageNames.first{
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
            }
            .padding(6)
            .background(Color.red)
            .cornerRadius(10)
        }
        //Restaurant Name and CityName
        private var textCard: some View {
            VStack (alignment: .leading, spacing: 4){
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(location.cityName)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        //Button for restaurant Menu
        private var menuButton: some View{
            Button{
                vm.sheetMenu = location
            }label: {
                Text("Menu")
                    .font(.headline)
                    .frame(width: 120,height: 30)
            }
            .buttonStyle(.borderedProminent)
         
        }
        //Button for next restaurnat:
        private var nxtRaflaButton: some View{
            Button{
                vm.nxtButtonPress()
            }label: {
                Text("Nxt Rafla")
                    .font(.headline)
                    .frame(width: 120,height: 30)
            }
            .buttonStyle(.bordered)
        }
        //Button to get directions
        private var directionsButton: some View{
            Button{
                
            }label: {
                Text("Directions")
                    .font(.headline)
                    .frame(width: 120,height: 30)
            }
            .buttonStyle(.bordered)
        }
    }
