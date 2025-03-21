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
    
    init(viewModel: CitiesViewModel = CitiesViewModel(), selectedCity: Binding<City?>) {
        self.viewModel = viewModel
        self._selectedCity = selectedCity
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Filter cities", text: $viewModel.filterText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Toggle("Only favorites", isOn: $showOnlyFavorites)
                    .padding(.horizontal)
                    .onChange(of: showOnlyFavorites) { _ in
                        if showOnlyFavorites {
                            viewModel.displayedCities = viewModel.filteredCities.filter { viewModel.isFavorite($0.id) }
                        } else {
                            viewModel.resetDisplayedCities()
                        }
                    }
                
                // Option to change search strategy
                Picker("Search by", selection: $searchChoice) {
                    Text("Name").tag(0)
                    Text("Country").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: searchChoice) { choice in
                    if choice == 0 {
                        viewModel.setSearchStrategy(NameSearchStrategy())
                    } else {
                        // new strategy
                    }
                }
                
                GeometryReader { geometry in
                    if geometry.size.width > geometry.size.height {
                        // LANDSCAPE
                        List(viewModel.displayedCities, id: \.id) { city in
                            CityRow(city: city, isFavorite: viewModel.isFavorite(city.id), toggleFavorite: {
                                viewModel.toggleFavorite(for: city.id)
                            }, selectedCity: $selectedCity)
                            .onTapGesture {
                                selectedCity = city
                            }
                            .onAppear {
                                viewModel.loadMoreCitiesIfNeeded(currentItem: city)
                            }
                        }
                    } else {
                        // PORTRAIT
                        List(viewModel.displayedCities, id: \.id) { city in
                            NavigationLink(destination: CityDetailView(city: city)) {
                                CityRow(city: city, isFavorite: viewModel.isFavorite(city.id), toggleFavorite: {
                                    viewModel.toggleFavorite(for: city.id)
                                }, selectedCity: $selectedCity)
                                .onAppear {
                                    viewModel.loadMoreCitiesIfNeeded(currentItem: city)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cities")
        }
    }
    
    @State private var searchChoice = 0
    @State private var showOnlyFavorites: Bool = false
}



