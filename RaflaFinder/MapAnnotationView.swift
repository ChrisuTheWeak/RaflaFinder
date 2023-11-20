//
//  MapAnnotationView.swift
//  RaflaFinder
//
//  Created by iosdev on 20.11.2023.
//

import SwiftUI

struct MapAnnotationView: View {
    
    let accentColour = Color("AccentColor")
    
    var body: some View {
        VStack (spacing: 0){
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30,height: 30)
                .font(.headline)
            Image(systemName: "triangle.tophalf.filled")
                .resizable()
                .scaledToFit()
                .frame(width: 15,height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-4)
                .padding(.bottom, 32)
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
    }
}
