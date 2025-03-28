//
//  NameSearchStrategyTests.swift
//  Mobile Challenge city UalaTests
//
//  Created by Nicolas Dolinkue on 24/03/2025.
//

import XCTest
@testable import Mobile_Challenge_city_Uala 

final class NameSearchStrategyTests: XCTestCase {
    var searchStrategy: CityNameSearchStrategy!
    var cities: [City]!
    
    override func setUp() {
        super.setUp()
        searchStrategy = CityNameSearchStrategy()
        cities = [
            City(id: 1, country: "USA", name: "New York", coord: Coordinate(lon: -74.0060, lat: 40.7128)),
            City(id: 2, country: "USA", name: "Los Angeles", coord: Coordinate(lon: -118.2437, lat: 34.0522)),
            City(id: 3, country: "UK", name: "London", coord: Coordinate(lon: -0.1278, lat: 51.5074)),
            City(id: 4, country: "France", name: "Paris", coord: Coordinate(lon: 2.3522, lat: 48.8566)),
            City(id: 5, country: "Germany", name: "Berlin", coord: Coordinate(lon: 13.4050, lat: 52.5200))
        ]
    }
    
    func testSearch_WithExistingPrefix_ShouldReturnMatchingCities() {
        let result = searchStrategy.search(cities: cities, query: "Lo")
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "London")
    }
    
    func testSearch_WithNonExistingPrefix_ShouldReturnEmptyArray() {
        let result = searchStrategy.search(cities: cities, query: "Madrid")
        XCTAssertTrue(result.isEmpty)
    }
    
    func testSearch_WithEmptyQuery_ShouldReturnAllCities() {
        let result = searchStrategy.search(cities: cities, query: "")
        XCTAssertEqual(result.count, cities.count)
    }
    
    func testSearch_WithPartialMatch_ShouldReturnCity() {
        let result = searchStrategy.search(cities: cities, query: "Pa")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Paris")
    }
    
    func testSearch_WithSingleCharacter_ShouldReturnMatchingCities() {
        let result = searchStrategy.search(cities: cities, query: "B")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Berlin")
    }
}

