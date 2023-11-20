//
//  RestaurantsListView.swift
//  RaflaFinder
//
//  Created by iosdev on 20.11.2023.
//

import SwiftUI

struct RestaurantsListView: View {
    @EnvironmentObject private var vm: RestaurantsViewModel
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

struct RestaurantsListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsListView()
            .environmentObject(RestaurantsViewModel())
    }
}
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
