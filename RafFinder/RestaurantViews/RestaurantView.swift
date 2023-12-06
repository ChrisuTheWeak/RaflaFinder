//
//  RestaurantView.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//


import SwiftUI
import MapKit
import CoreLocation


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
                restaurnatPreview
            }
        }
        .sheet(item: $vm.sheetMenu, onDismiss: nil){ location in Menu(location: location)
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
        
        //MainView is the top bar that has the navigation and name.
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
        //MapLayer is the map it self and annotations with userLocation.
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
        private var restaurnatPreview: some View{
            ZStack {
                ForEach(vm.locations){ location in
                    if vm.mapLocation == location{
                        RestaurantPreview(location: location)
                        .padding()
                    }
                }
            }
        }
        class LocationManager {
            let locationManager = CLLocationManager()
            func requestLocation (){
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
