//
//  NameSearchStrategy.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import Foundation

class NameSearchStrategy: SearchStrategy {
    func search(cities: [City], query: String) -> [City] {
        guard !query.isEmpty else { return cities }

        let lowercasedQuery = query.lowercased()
        let sortedCities = cities.sorted { $0.name.lowercased() < $1.name.lowercased() } // Asegurar orden
        if let index = binarySearch(sortedCities, query: lowercasedQuery) {
            return sortedCities[index...].prefix { $0.name.lowercased().hasPrefix(lowercasedQuery) }
        }
        
        return []
    }

    private func binarySearch(_ cities: [City], query: String) -> Int? {
        var left = 0
        var right = cities.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            let cityName = cities[mid].name.lowercased()
            
            if cityName.hasPrefix(query) {
                if mid == 0 || !cities[mid - 1].name.lowercased().hasPrefix(query) {
                    return mid // Encontró el primer índice con el prefijo
                }
                right = mid - 1 // Buscar más a la izquierda
            } else if cityName < query {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}

