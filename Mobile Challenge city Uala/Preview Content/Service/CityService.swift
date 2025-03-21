//
//  CityService.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 21/03/2025.
//

import Foundation
import Combine

class CityService: CityFetching {
    static let shared = CityService()
    
    private init() {}
    
    func fetchCities() -> AnyPublisher<[City], Error> {
        guard let url = URL(string: "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [City].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
