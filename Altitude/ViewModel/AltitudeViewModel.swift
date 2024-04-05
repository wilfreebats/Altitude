//
//  AltitudeViewModel.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/1/24.
//

import Foundation
import CoreMotion

class AltitudeViewModel: ObservableObject {
    @Published var altitude: AltitudeModel?
    @Published var baromemter: BarometerModel?
    
    let altimeter = CMAltimeter()
    
    func getAltitude() {
        
        var alt: Double = 0
        var baro: Double = 0

        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                if (error == nil) {
                    alt = data?.relativeAltitude as! Double
                    baro = data?.pressure as! Double
                    
                    self.altitude = AltitudeModel(altitude: alt)
                    self.baromemter = BarometerModel(barometer: baro)
                    
                    print("DEBUG: ALTITUDE AND BAROMETER DATA .......")
                    print("Altitude: \(alt)")
                    print("Barometer: \(baro)")
                }
            })
        }
    }
}
