//
//  CitiesViewModel.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import Combine
import SwiftUI

class CitiesViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var filteredCities: [City] = []
    @Published var displayedCities: [City] = []
    @Published var favorites: Set<Int> = []
    @Published var filterText: String = ""
    @Published var isLoading: Bool = true
    
    private var searchStrategy: SearchStrategy
    private let loadIncrement = 20
    private var cancellables: Set<AnyCancellable> = []
    private let cityService: CityFetching
    private let favoritesManager: FavoritesManaging
    private var countInit = 0
    
    init(cityService: CityFetching = CityService.shared,
         favoritesManager: FavoritesManaging = FavoritesManager(),
         searchStrategy: SearchStrategy = CityNameSearchStrategy()) {
        self.cityService = cityService
        self.favoritesManager = favoritesManager
        self.searchStrategy = searchStrategy
        fetchCities()
        
        $filterText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] newText in
                self.performSearch(query: newText)
                self.resetDisplayedCities()
            }
            .store(in: &cancellables)
        
        self.favorites = favoritesManager.loadFavorites()
    }
    
    func fetchCities() {
        isLoading = true
        cityService.fetchCities()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching cities: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cities in
                guard let self = self else { return }
                self.cities = self.sortedCities(cities)
                self.filteredCities = self.cities
                self.resetDisplayedCities()
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func performSearch(query: String) {
        filteredCities = searchStrategy.search(cities: cities, query: query)
    }
    
    private func sortedCities(_ cities: [City]) -> [City] {
        cities.sorted {
            let first = "\($0.name), \($0.country)"
            let second = "\($1.name), \($1.country)"
            return first < second
        }
    }
    
    func resetDisplayedCities() {
        self.displayedCities = Array(self.filteredCities.prefix(loadIncrement))
    }
    
    func loadMoreCitiesIfNeeded(currentItem city: City?) {
        guard let city = city else {
            return
        }
        
        let thresholdIndex = displayedCities.index(displayedCities.endIndex, offsetBy: -8)
        if displayedCities.firstIndex(where: { $0.id == city.id }) == thresholdIndex {
            self.displayedCities.append(contentsOf: filteredCities[displayedCities.count..<min(displayedCities.count + loadIncrement, filteredCities.count)])
        }
    }
    
    func toggleFavorite(for cityId: Int) {
        favoritesManager.toggleFavorite(id: cityId, favorites: &favorites)
    }
    
    func isFavorite(_ cityId: Int) -> Bool {
        favorites.contains(cityId)
    }
    
    func setSearchStrategy(_ strategy: SearchStrategy) {
        self.searchStrategy = strategy
    }
}
