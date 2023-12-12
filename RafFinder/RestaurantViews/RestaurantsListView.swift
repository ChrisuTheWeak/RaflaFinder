//
//  RestaurantsListView.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import SwiftUI
// a dropdown menu of restaurants Displays name and city.
struct RestaurantsListView: View {
    @ObservedObject var vm: RestaurantsViewModel
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                Button {
                    vm.showNext(location: location)
                } label: {
                    listRowView(location: location)
                }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.gray.opacity(0.4))
            }
        }
        .listStyle(PlainListStyle())
    }
}

// Displays Picture in Hstack and child shown in Vstack, Done to have a clean UI
extension RestaurantsListView{
    private func listRowView (location: Location) -> some View{
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 80)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth:.infinity, alignment: .leading)
        }
    }
}
