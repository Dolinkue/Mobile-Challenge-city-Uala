//
//  CityDetailView.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import SwiftUI
import MapKit

struct CityDetailView: View {
    let city: City

    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon))
                .frame(height: 300)
            
            Text(Constants.cityDetailTitle)
                .font(.largeTitle)
            
            Text("Country: \(city.country)")
            Text("Coordinates: \(city.coord.lat), \(city.coord.lon)")
            
            Spacer()
        }
        .padding()
    }
}
