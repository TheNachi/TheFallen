//
//  MeteorMapViewModelTests.swift
//  TheFallenTests
//
//  Created by Munachimso Ugorji on 26/09/2021.
//

import XCTest
import MapKit
import Foundation
@testable import TheFallen

class MeteorMapViewModelTests: XCTestCase {
    let meteor =
        MeteorModel(name: "Angths", mass: "234", year: "1982-12-01", reclat: "23.999", reclong: "34.98")
    
    func testGetLocation() {
        let viewModel = MeteorMapViewModel(with: meteor)
        guard let lat = Double(meteor.reclat!),
              let long = Double(meteor.reclong!) else { return }
        let location = CLLocation(latitude: lat, longitude: long)
        
        XCTAssertEqual(viewModel.getLocation()?.coordinate.latitude, location.coordinate.latitude)
        XCTAssertEqual(viewModel.getLocation()?.coordinate.longitude, location.coordinate.longitude)
    }
    
    func testGetMeteor() {
        let viewModel = MeteorMapViewModel(with: meteor)
        
        XCTAssertEqual(viewModel.getMeteor(), meteor)
    }
    
    func testGetMeteorName() {
        let viewModel = MeteorMapViewModel(with: meteor)
        
        XCTAssertEqual(viewModel.getMeteorName(), "Angths")
    }
    
    func testNoName() {
        let viewModel = MeteorMapViewModel(with: nil)
        
        XCTAssertEqual(viewModel.getMeteorName(), "")
    }
    
    func testNoLocation() {
        let viewModel = MeteorMapViewModel(with: nil)
        
        XCTAssertNil(viewModel.getLocation()?.coordinate.latitude)
        XCTAssertNil(viewModel.getLocation()?.coordinate.longitude)
       
    }

}
