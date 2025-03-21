//
//  CityModel.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import Foundation

struct City: Identifiable, Codable {
    let id: Int
    let country: String
    let name: String
    let coord: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country, name, coord
    }
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}
