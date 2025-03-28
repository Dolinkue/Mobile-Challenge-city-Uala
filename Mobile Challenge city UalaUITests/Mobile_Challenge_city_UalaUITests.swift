//
//  Mobile_Challenge_city_UalaUITests.swift
//  Mobile Challenge city UalaUITests
//
//  Created by Nicolas Dolinkue on 20/03/2025.
//

import XCTest

final class Mobile_Challenge_city_UalaUITests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    func testCityDetailView_DisplaysCityInfo() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest-OrientedOnly")
        app.launch()
        
        
        let cityName = "t Zand"
        let cityCell = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", cityName)).firstMatch
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true && hittable == true"),
            object: cityCell
        )
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 15)
        XCTAssert(result == .completed, "No se encontró la celda en 15 segundos")
        
        if !cityCell.isHittable {
            app.swipeUp()
        }

        cityCell.tap()
        
        // Validar la vista de detalle
        let title = app.staticTexts["City Info"]
        XCTAssertTrue(title.exists)
        
        let countryText = app.staticTexts["Country: NL"]
        XCTAssertTrue(countryText.exists)
        
        let coordinatesText = app.staticTexts["Coordinates: 52,836670, 4,755560"]
        XCTAssertTrue(coordinatesText.exists)
    }
}
