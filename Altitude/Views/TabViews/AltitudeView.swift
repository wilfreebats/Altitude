//
//  AltitudeView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/29/24.
//

import SwiftUI
import CoreLocation

struct AltitudeView: View {    
    @EnvironmentObject var vm: AltitudeViewModel
    @EnvironmentObject var weatherData: DataViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(String(format: "%.1f", vm.altitude?.altitude ?? 0))
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                    Text("MASL")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                }
                .padding(.top, 110)
                .padding(.bottom, 40)
                
                VStack {
                    Text("\(weatherData.weather?.name ?? "--"), \(weatherData.weather?.sys.country ?? "--")")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)

                }
                .padding(.top, 20)
                
                VStack {
                    if let coordinates = weatherData.coordinates {
                        Text("Latitude: \(coordinates.lat)")
                        Text("Longitude: \(coordinates.long)")
                    }
                }
                .padding(.top, 10)
            }
            
            .refreshable {
                do {
                    try await weatherData.fetchWeatherData(latitude: weatherData.coordinates!.lat, longitude: weatherData.coordinates!.long)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            .onAppear {
                vm.getAltitude()
                weatherData.getCoordinates()
            }
            
            .task {
                do {
                    try await weatherData.fetchWeatherData(latitude: weatherData.coordinates!.lat, longitude: weatherData.coordinates!.long)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            .navigationTitle("Altitude")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

//#Preview {
//    AltitudeView()
//}
