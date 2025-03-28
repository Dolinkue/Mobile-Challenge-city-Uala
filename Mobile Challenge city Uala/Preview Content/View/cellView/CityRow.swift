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
    let isLandscape: Bool
    @Binding var selectedCity: City?
    
    var body: some View {
        if isLandscape {
            CityRowContent()
                .onTapGesture {
                    selectedCity = city
                }
        } else {
            NavigationLink(destination: CityDetailView(city: city)) {
                CityRowContent()
            }
        }
    }
    
    @ViewBuilder
    private func CityRowContent() -> some View {
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
                Image(systemName: isFavorite ? Constants.isFavorite : Constants.noFavorite)
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .frame(width: 25, height: 25)
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

