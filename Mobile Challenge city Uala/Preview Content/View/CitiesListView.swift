//
//  CitiesListView.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import SwiftUI
import MapKit

struct CitiesListView: View {
    @ObservedObject var viewModel: CitiesViewModel
    @Binding var selectedCity: City?
    @State private var searchChoice = 0
    @State private var showOnlyFavorites: Bool = false
    
    init(viewModel: CitiesViewModel = CitiesViewModel(), selectedCity: Binding<City?>) {
        self.viewModel = viewModel
        self._selectedCity = selectedCity
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(Constants.textFieldFilter, text: $viewModel.filterText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Toggle(Constants.toggleTitle, isOn: $showOnlyFavorites)
                    .padding(.horizontal)
                    .onChange(of: showOnlyFavorites, initial: false, { _, _ in
                        if showOnlyFavorites {
                            viewModel.displayedCities = viewModel.filteredCities.filter { viewModel.isFavorite($0.id) }
                        } else {
                            viewModel.resetDisplayedCities()
                        }
                    })
                
                if viewModel.isLoading {
                    SkeletonListView()
                } else {
                    GeometryReader { geometry in
                        List(viewModel.displayedCities, id: \.id) { city in
                            CityRow(
                                city: city,
                                isFavorite: viewModel.isFavorite(city.id),
                                toggleFavorite: { viewModel.toggleFavorite(for: city.id) },
                                isLandscape: geometry.size.width > geometry.size.height,
                                selectedCity: $selectedCity
                            )
                            .onAppear {
                                viewModel.loadMoreCitiesIfNeeded(currentItem: city)
                            }
                        }
                    }
                }
            }
        }
    }
}



