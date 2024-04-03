//
//  AltitudeViewModel.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/1/24.
//

import Foundation
import CoreMotion
import CoreLocation

class AltitudeViewModel: ObservableObject {
    @Published var altitude: AltitudeModel?
    @Published var baromemter: BarometerModel?
    
    let locationManager = CLLocationManager()
    let altimeter = CMAltimeter()
    
    func getAltitude() {
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var alt: Double = 0
        var baro: Double = 0

        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                if (error == nil) {
                    //self.altitude = data?.relativeAltitude as! Double
                    alt = data?.relativeAltitude as! Double
                    baro = data?.pressure as! Double
                    
                    self.altitude = AltitudeModel(altitude: alt)
                    self.baromemter = BarometerModel(barometer: baro)
                    
                    print("DEBUG: ALTITUDE DATA .......")
                    print("Altitude: \(alt)")
                    print("Barometer: \(baro)")
                }
            })
        }
    }
}
