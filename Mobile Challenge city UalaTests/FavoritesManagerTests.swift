//
//  FavoritesManagerTests.swift
//  Mobile Challenge city UalaTests
//
//  Created by Nicolas Dolinkue on 24/03/2025.
//

@testable import Mobile_Challenge_city_Uala
import XCTest

final class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!
    let testUserDefaults = UserDefaults(suiteName: "testSuite")!
    
    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager()
        testUserDefaults.removePersistentDomain(forName: "testSuite")
    }
    
    override func tearDown() {
        testUserDefaults.removePersistentDomain(forName: "testSuite")
        super.tearDown()
    }
    
    func testToggleFavorite_AddsFavorite_WhenNotAlreadyPresent() {
        var favorites = Set<Int>()
        favoritesManager.toggleFavorite(id: 1, favorites: &favorites)
        
        XCTAssertTrue(favorites.contains(1), "El ID 1 debería haber sido agregado a los favoritos")
    }
    
    func testToggleFavorite_RemovesFavorite_WhenAlreadyPresent() {
        var favorites: Set<Int> = [1]
        favoritesManager.toggleFavorite(id: 1, favorites: &favorites)
        
        XCTAssertFalse(favorites.contains(1), "El ID 1 debería haber sido eliminado de los favoritos")
    }
    
    func testSaveAndLoadFavorites_PersistsDataCorrectly() {
        var favorites: Set<Int> = [1, 2, 3]
        favoritesManager.toggleFavorite(id: 4, favorites: &favorites) // Agrega el 4
        
        let loadedFavorites = favoritesManager.loadFavorites()
        XCTAssertTrue(loadedFavorites.contains(4), "El ID 4 debería estar en los favoritos guardados")
    }
}

