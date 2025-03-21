//
//  CityRow.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import SwiftUI

struct CityRow: View {
    let city: City
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    
    @State private var isNavigationActive = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(city.name), \(city.country)")
                    .font(.headline)
                Text("Lon: \(city.coord.lon), Lat: \(city.coord.lat)")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
            
            
            NavigationLink("", destination: CityDetailView(city: city))
        }
        .padding()
        .contentShape(Rectangle()) // Asegura que el HStack no intercepte toques
        .buttonStyle(PlainButtonStyle())
    }
}
