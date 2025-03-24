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
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
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
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 8)
        XCTAssert(result == .completed, "No se encontró la celda en 8 segundos")
        
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
}
