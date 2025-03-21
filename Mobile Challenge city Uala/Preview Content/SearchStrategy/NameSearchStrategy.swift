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
        return cities.filter { $0.name.localizedCaseInsensitiveHasPrefix(query) }
    }
}

extension String {
    func localizedCaseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return self.lowercased().hasPrefix(prefix.lowercased())
    }
}

