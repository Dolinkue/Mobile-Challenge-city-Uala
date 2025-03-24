//
//  MapViewTests.swift
//  Mobile Challenge city UalaTests
//
//  Created by Nicolas Dolinkue on 24/03/2025.
//


@testable import Mobile_Challenge_city_Uala
import XCTest
import SwiftUI
import MapKit

class MapViewTests: XCTestCase {

    func testMapViewSetup() {
        // Dado ciertos valores esperados...
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0092)

        // Cuando configuras el MapView directamente (en una instancia concreta)
        let mapView = MKMapView()
        let span = MKCoordinateSpan(latitudeDelta: 90.0, longitudeDelta: 180.0)
        let expectedRegion = MKCoordinateRegion(center: expectedCoordinate, span: span)
        mapView.setRegion(expectedRegion, animated: false)

        // Entonces asegúrate de que el MapView tiene configurado el mismo region
        XCTAssertEqual(mapView.region.center.latitude, expectedCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(mapView.region.center.longitude, expectedCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(mapView.region.span.latitudeDelta, span.latitudeDelta, accuracy: 0.0001)
        XCTAssertEqual(mapView.region.span.longitudeDelta, span.longitudeDelta, accuracy: 0.0001)
    }
}






