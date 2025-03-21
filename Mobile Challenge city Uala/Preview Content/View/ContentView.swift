//
//  ContentView.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCity: City? // Ciudad seleccionada
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // LANDSCAPE
                HStack {
                    CitiesListView(selectedCity: $selectedCity)
                        .frame(width: geometry.size.width / 2)
                    
                    if let city = selectedCity {
                        ScrollView {
                            CityDetailView(city: city)
                                .frame(width: geometry.size.width / 2)
                        }
                    } else {
                        Text("Selecciona una ciudad")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                // PORTRAIT
                CitiesListView(selectedCity: $selectedCity)
            }
        }
    }
}

#Preview {
    ContentView()
}
