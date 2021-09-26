//
//  TheFallenTests.swift
//  TheFallenTests
//
//  Created by Munachimso Ugorji on 22/09/2021.
//

import XCTest
@testable import TheFallen

class MeteorViewModelTests: XCTestCase {
    let meteors = [
        MeteorModel(name: "Angths", mass: "234", year: "1982-12-01", reclat: "23.999", reclong: "34.98"),
        MeteorModel(name: "Agtdg", mass: "34", year: "1922-04-01", reclat: "45.45", reclong: "74.98"),
        MeteorModel(name: "Dfgth", mass: "676", year: "1967-06-01", reclat: "23.87", reclong: "25.9")
    ]
    
    let viewModel = MeteorViewModel(with: nil)
    
    func testSortByMass() {
        viewModel.updateMeteorList(with: meteors)
        viewModel.sortByMass()
        
        XCTAssertEqual(viewModel.getMeteor(index: 0), meteors[1])
        XCTAssertEqual(viewModel.getMeteor(index: 1), meteors[0])
        XCTAssertEqual(viewModel.getMeteor(index: 2), meteors[2])
    }
    
    func testGetMeteorCount() {
        viewModel.updateMeteorList(with: meteors)
        XCTAssertEqual(viewModel.getMeteorCount(), 3)
    }
    
    func testGetMeteorAndSortByDate() {
        viewModel.updateMeteorList(with: meteors)
        XCTAssertEqual(viewModel.getMeteor(index: 2).name, "Angths")
        XCTAssertEqual(viewModel.getMeteor(index: 2).mass, "234")
        XCTAssertEqual(viewModel.getMeteor(index: 2).year, "1982-12-01")
        XCTAssertEqual(viewModel.getMeteor(index: 2).reclat, "23.999")
        XCTAssertEqual(viewModel.getMeteor(index: 2).reclong, "34.98")
        
        XCTAssertEqual(viewModel.getMeteor(index: 0).name, "Agtdg")
        XCTAssertEqual(viewModel.getMeteor(index: 0).mass, "34")
        XCTAssertEqual(viewModel.getMeteor(index: 0).year, "1922-04-01")
        XCTAssertEqual(viewModel.getMeteor(index: 0).reclat, "45.45")
        XCTAssertEqual(viewModel.getMeteor(index: 0).reclong, "74.98")
    }
    
    func testGetMeteorCellViewModel() {
        viewModel.updateMeteorList(with: meteors)
        let meteorCellModel = viewModel.getMeteorCellViewModel(index: 0)
        
        XCTAssertEqual(meteorCellModel.meteorCrashDate, meteors[1].year?.dateStringConversation())
        XCTAssertEqual(meteorCellModel.meteorName, meteors[1].name)
        XCTAssertEqual(meteorCellModel.meteorSize, meteors[1].mass)
    }
    
    func testUpdateFromFavourites() {
        viewModel.updateMeteorList(with: meteors)
        XCTAssertEqual(viewModel.getMeteorCount(), 3)
        
        viewModel.updateFromFavourites()
        XCTAssertEqual(viewModel.getMeteorCount(), FavouritesManager.shared.getFavourites().count)
    }

}
