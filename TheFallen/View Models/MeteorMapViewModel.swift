//
//  MeteorMapViewModel.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 24/09/2021.
//

import Foundation
import MapKit

struct MeteorMapViewModel {
    private let meteor: MeteorModel?
    
    init(with meteor: MeteorModel?) {
        self.meteor = meteor
    }
    
    public func getLocation() -> CLLocation? {
        if let latitude = meteor?.reclat,
           let longitude = meteor?.reclong,
           let lattDouble = Double(latitude),
           let longDouble = Double(longitude) {
            return CLLocation(latitude: Double(lattDouble), longitude: Double(longDouble))
        }
        return nil
    }
    
    public func getMeteor() -> MeteorModel? {
        return self.meteor
    }
    
    public func getMeteorName() -> String {
        return meteor?.name ?? ""
    }
}
