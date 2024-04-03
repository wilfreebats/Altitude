//
//  ContentView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/25/24.
//

import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {
    
    @State private var altitude: Double = 0.0
    @State private var speed: Double = 0.0
    
    let altimeter = CMAltimeter()
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f", altitude))
                .font(.system(size: 100))
                .fontWeight(.bold)
            Text("MASL")
                .font(.system(size: 40))
                .fontWeight(.heavy)
        }
        .padding(.top, 200)
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20, content: {
                Text("Other data")
                    .bold().padding(.bottom)
                HStack {
                    RowView(logo: "car.side", name: "Speed", value: String(format: "%.0f kph", speed))
                    Spacer()
                    RowView(logo: "car", name: "Speed", value: "5kph")
                }
                HStack {
                    RowView(logo: "car", name: "Speed", value: "5kph")
                    Spacer()
                    RowView(logo: "car", name: "Speed", value: "5kph")
                }
            })
            .padding()
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            if let speed = locationManager.location?.speed {
                //self.altitude = altitude
                self.speed = speed
                print(speed)
            }
            
            if CMAltimeter.isRelativeAltitudeAvailable() {
                altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                    if (error == nil) {
                        self.altitude = data?.relativeAltitude as! Double
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
