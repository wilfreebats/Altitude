//
//  Model.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/30/24.
//

import Foundation

struct AltitudeModel {
    var altitude: Double
    
    static var sampleData = AltitudeModel(altitude: 25)
}

struct BarometerModel {
    var barometer: Double
    
    static var sampleData = BarometerModel(barometer: 920)
}

struct SpeedModel {
    var speed: Double
    
    static var sampleData = SpeedModel(speed: 35)
}

struct CoordinatesModel {
    var lat: Double
    var long: Double
    
    static var sampleData = CoordinatesModel(lat: 155, long: 155)
}

