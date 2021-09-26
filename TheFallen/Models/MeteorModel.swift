//
//  MeteorModel.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 23/09/2021.
//

import Foundation

struct MeteorModel: Codable, Equatable {
    var name: String?
//    var id: String
//    var nametype: String
//    var recclass: String
    var mass: String?
//    var fall: String
    var year: String?
    var reclat: String?
    var reclong: String?
//    var geolocation: GeolocationModel?
}

struct GeolocationModel: Codable {
    var type: String
    var coordinates: [Double]
}

