//
//  CityDetailViewTests.swift
//  Mobile Challenge city UalaTests
//
//  Created by Nicolas Dolinkue on 24/03/2025.
//

import XCTest
import SwiftUI
import MapKit
@testable import Mobile_Challenge_city_Uala 

final class CityDetailViewTests: XCTestCase {
    func testCityDetailView_ContainsCorrectInformation() {
        // Given
        let city = City(id: 1, country: "France", name: "Paris", coord: Coordinate(lon: 2.3522, lat: 48.8566))
        let view = CityDetailView(city: city)
        
        // When
        let sut = UIHostingController(rootView: view)
        
        // Then
        XCTAssertNotNil(sut.view, "CityDetailView no debería ser nil")

    }

    // Método auxiliar para buscar texto en la vista
    private func findText(in view: UIView, text: String) -> Bool {
        if let label = view as? UILabel, label.text == text {
            return true
        }
        for subview in view.subviews {
            if findText(in: subview, text: text) {
                return true
            }
        }
        return false
    }
}




