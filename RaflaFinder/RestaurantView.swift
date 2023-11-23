//
//  RestaurantView.swift
//  RaflaFinder
//
//  Created by iosdev on 19.11.2023.
//

import SwiftUI
import MapKit


struct RestaurantView: View {
    @EnvironmentObject private var vm: RestaurantsViewModel
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            VStack(spacing: 0){
                
                mainView
                    .padding()
                Spacer()
            }
        }
    }
}
    
    struct RestaurantView_Previews: PreviewProvider {
        static var previews: some View {
            RestaurantView()
                .environmentObject(RestaurantsViewModel())
        }
    }
    extension RestaurantView{
        private var mainView: some View{
            VStack{
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Button(action: vm.toggleRestaurants){
                            Image(systemName: "arrow.left")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .rotationEffect(Angle(degrees: vm.showRestourants ? -90 : 0))
                        }
                        
                    }
                if  vm.showRestourants{
                    RestaurantsListView()
                }
            }
            .background(.thickMaterial.opacity(0.5))
            .cornerRadius(10)
        }
        
        private var mapLayer: some View{
            Map(coordinateRegion: $vm.mapRegion,
                showsUserLocation: true,
                annotationItems: vm.locations,
                annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates){
                    MapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.6)
                        .onTapGesture {
                            vm.showNext(location: location)
                        }
                }
            })
            
        }
        //private var restaurnatPreview: some View{
            
        //}
    }

