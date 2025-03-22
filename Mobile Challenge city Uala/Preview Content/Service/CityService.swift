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
        guard let url = URL(string: Constants.url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [City].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
