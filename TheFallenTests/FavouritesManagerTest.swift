//
//  FavouritesManagerTest.swift
//  TheFallenTests
//
//  Created by Munachimso Ugorji on 26/09/2021.
//

import XCTest
@testable import TheFallen

class FavouritesManagerTest: XCTestCase {
    let meteor =
        MeteorModel(name: "Angths", mass: "234", year: "1982-12-01", reclat: "23.999", reclong: "34.98")
    
    func testIsFavourite() {
        XCTAssertFalse(FavouritesManager.shared.isFavourite(meteor: meteor))
    }
    
    func testToggleFavourites() {
        FavouritesManager.shared.toggleFavourites(meteor: meteor)
        XCTAssertTrue(FavouritesManager.shared.isFavourite(meteor: meteor))
        FavouritesManager.shared.toggleFavourites(meteor: meteor)
    }

}
