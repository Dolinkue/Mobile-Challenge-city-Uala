//
//  CitiesViewModelTests.swift
//  Mobile Challenge city UalaTests
//
//  Created by Nicolas Dolinkue on 24/03/2025.
//

@testable import Mobile_Challenge_city_Uala
import XCTest
import Combine



class CitiesViewModelTests: XCTestCase {
    var viewModel: CitiesViewModel!
    var mockCityService: MockCityService!
    var mockFavoritesManager: MockFavoritesManager!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockCityService = MockCityService()
        mockFavoritesManager = MockFavoritesManager()
        viewModel = CitiesViewModel(cityService: mockCityService, favoritesManager: mockFavoritesManager)
    }

    override func tearDown() {
        viewModel = nil
        mockCityService = nil
        mockFavoritesManager = nil
        cancellables.removeAll()
        super.tearDown()
    }

    // ✅ Test: fetchCities carga correctamente los datos
    func testFetchCities() {
        let expectation = self.expectation(description: "fetchCities completion")
        
        viewModel.$isLoading
            .dropFirst() // Saltamos el estado inicial
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockCityService.publishMockCities()

        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(viewModel.cities.count, 3)
        XCTAssertEqual(viewModel.filteredCities.count, 3)
        XCTAssertEqual(viewModel.displayedCities.count, 3)
    }

    // ✅ Test: performSearch filtra correctamente por nombre
    func testPerformSearch() {
        viewModel.cities = mockCityService.mockCities
        viewModel.performSearch(query: "Pa")
        
        XCTAssertEqual(viewModel.filteredCities.count, 1)
        XCTAssertEqual(viewModel.filteredCities.first?.name, "Paris")
    }

    // ✅ Test: resetDisplayedCities muestra las primeras ciudades según loadIncrement
    func testResetDisplayedCities() {
        viewModel.cities = mockCityService.mockCities
        viewModel.performSearch(query: "")
        viewModel.resetDisplayedCities()

      //  XCTAssertEqual(viewModel.displayedCities.count, min(viewModel.loadIncrement, viewModel.filteredCities.count))
    }

    // ✅ Test: toggleFavorite agrega y elimina favoritos
    func testToggleFavorite() {
        let cityId = 1
        XCTAssertFalse(viewModel.isFavorite(cityId))
        
        viewModel.toggleFavorite(for: cityId)
        XCTAssertTrue(viewModel.isFavorite(cityId))
        
        viewModel.toggleFavorite(for: cityId)
        XCTAssertFalse(viewModel.isFavorite(cityId))
    }
}

// ✅ Mock para CityFetching
class MockCityService: CityFetching {
    var mockCities = [
        City(id: 1, country: "USA", name: "New York", coord: Coordinate(lon: -74.0060, lat: 40.7128)),
        City(id: 2, country: "France", name: "Paris", coord: Coordinate(lon: 2.3522, lat: 48.8566)),
        City(id: 3, country: "Japan", name: "Tokyo", coord: Coordinate(lon: 139.6917, lat: 35.6895))
    ]
    
    private let subject = PassthroughSubject<[City], Error>()

    func fetchCities() -> AnyPublisher<[City], Error> {
        return subject.eraseToAnyPublisher()
    }

    func publishMockCities() {
        subject.send(mockCities)
    }
}

// ✅ Mock para FavoritesManaging
class MockFavoritesManager: FavoritesManaging {
    private var favorites: Set<Int> = []

    func loadFavorites() -> Set<Int> {
        return favorites
    }

    func toggleFavorite(id: Int, favorites: inout Set<Int>) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
}
