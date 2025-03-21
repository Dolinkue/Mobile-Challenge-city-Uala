//
//  FavoritesManager.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import Foundation

class FavoritesManager: FavoritesManaging {
    private let favoritesKey = "favorites"
    
    func loadFavorites() -> Set<Int> {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let savedFavorites = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            return savedFavorites
        }
        return []
    }
    
    func toggleFavorite(id: Int, favorites: inout Set<Int>) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        saveFavorites(favorites)
    }
    
    private func saveFavorites(_ favorites: Set<Int>) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
