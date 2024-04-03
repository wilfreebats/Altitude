//
//  AltitudeViewModel.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/29/24.
//

import Foundation
import CoreMotion
import CoreLocation

class ViewModel: ObservableObject {
    //@Published var altitude: Double = 0
    @Published var newAltitude: AltitudeModel?
    @Published var speed: SpeedModel?
    @Published var coordinates: CoordinatesModel?
    
    let locationManager = CLLocationManager()
    let altimeter = CMAltimeter()
    
    func getAltitude() {
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var alt: Double = 0

        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                if (error == nil) {
                    //self.altitude = data?.relativeAltitude as! Double
                    alt = data?.relativeAltitude as! Double
                    self.newAltitude = AltitudeModel(altitude: alt)
                    
                    print("DEBUG: ALTITUDE DATA .......")
                    print("Altitude: \(alt)")
                }
            })
        }
    }
    
    func getSpeedAndCoordinates() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
            if let currentLocation = self.locationManager.location {
                let speed = currentLocation.speed
                let lat = currentLocation.coordinate.latitude
                let long = currentLocation.coordinate.longitude

                self.speed = SpeedModel(speed: (speed * 3.6))
                self.coordinates = CoordinatesModel(lat: lat, long: long)
                
                print("DEBUG: COORDINATES .......")
                print("Latitude: \(lat)")
                print("Longitude: \(long)")

            }
            self.getSpeedAndCoordinates()
        }
    }
}
