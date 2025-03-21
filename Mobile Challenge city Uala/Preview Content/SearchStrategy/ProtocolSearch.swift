//
//  ProtocolSearch.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import Foundation

protocol SearchStrategy {
    func search(cities: [City], query: String) -> [City]
}
