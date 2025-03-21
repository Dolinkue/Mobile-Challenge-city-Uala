//
//  ContentView.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Landscape layout logic
                HStack {
                    CitiesListView().frame(width: geometry.size.width / 2)
                    Color.blue // This could be a MapView or other component
                }
            } else {
                // Portrait layout logic
                CitiesListView()
            }
        }
    }
}

#Preview {
    ContentView()
}
