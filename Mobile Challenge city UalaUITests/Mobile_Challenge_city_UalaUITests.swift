//
//  Mobile_Challenge_city_UalaUITests.swift
//  Mobile Challenge city UalaUITests
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import XCTest

final class Mobile_Challenge_city_UalaUITests: XCTestCase {
    
    @MainActor
    func testCityDetailView_DisplaysCityInfo() {
        let app = XCUIApplication()
        app.launch()
        
        let cityName = "t Zand"
        let parisCell = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", cityName)).firstMatch
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true && hittable == true"),
            object: parisCell
        )
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        XCTAssert(result == .completed, "No se encontró la celda en 5 segundos")
        
        if !parisCell.isHittable {
            app.swipeUp()
        }

        parisCell.tap()
        
        // Validar la vista de detalle
        let title = app.staticTexts["City Info"]
        XCTAssertTrue(title.exists)
        
        let countryText = app.staticTexts["Country: NL"]
        XCTAssertTrue(countryText.exists)
        
        let coordinatesText = app.staticTexts["Coordinates: 52,836670, 4,755560"]
        XCTAssertTrue(coordinatesText.exists)
    }
    
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
