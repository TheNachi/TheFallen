//
//  MeteorCellViewModelTests.swift
//  TheFallenTests
//
//  Created by Munachimso Ugorji on 26/09/2021.
//

import XCTest
@testable import TheFallen

class MeteorCellViewModelTests: XCTestCase {
    let meteor =
        MeteorModel(name: "Angths", mass: "234", year: "1982-12-01", reclat: "23.999", reclong: "34.98")
    
    func testMergeDateAndSize() {
        let viewModel = MeteorCellViewModel(with: meteor)

        XCTAssertEqual(viewModel.mergeDateAndSize(), "Dec 01, 1982 · 234 kg")
    }
    
    func testEmptyCellViewModel() {
        let viewModel = MeteorCellViewModel(with: nil)
        
        XCTAssertEqual(viewModel.meteorCrashDate, "")
        XCTAssertEqual(viewModel.meteorSize, "")
        XCTAssertEqual(viewModel.meteorName, "")
    }
}
