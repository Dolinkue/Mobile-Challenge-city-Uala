//
//  Protocols.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import Combine
import Foundation

protocol CityFetching {
    func fetchCities() -> AnyPublisher<[City], Error>
}

protocol FavoritesManaging {
    func loadFavorites() -> Set<Int>
    func toggleFavorite(id: Int, favorites: inout Set<Int>)
}
