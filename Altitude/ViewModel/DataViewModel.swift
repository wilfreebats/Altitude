//
//  DataViewModel.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/2/24.
//

import Foundation
import CoreLocation

class DataViewModel: ObservableObject {
    @Published var coordinates: CoordinatesModel?
    @Published var weather: WeatherModel?
    
    
    let locationManager = CLLocationManager()
    
    let apiKey = "https://api.openweathermap.org/data/2.5/weather?appid=b2cd3504360beae095f4fa061a4a9092&units=metric"
    
    func fetchWeatherData(latitude: Double, longitude: Double) async throws {
        // Phone location urlString
        let urlString = "\(apiKey)&lat=\(latitude)&lon=\(longitude)"
        
        // FOR FIXED LOCATION: Zocca, IT urlString
        //let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=b2cd3504360beae095f4fa061a4a9092&units=metric"
        let url = URL(string: urlString)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = try JSONDecoder().decode(WeatherModel.self, from: data)
        
        print("DEBUG: Fetching weather data")
        print(decoder)
        DispatchQueue.main.sync {
            self.weather = decoder
        }
    }

    
    func getCoordinates() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let currentLocation = locationManager.location {
            let lat = currentLocation.coordinate.latitude
            let long = currentLocation.coordinate.longitude
            
            coordinates = CoordinatesModel(lat: lat, long: long)
            
            print("DEBUG: COORDINATES .......")
            print("Latitude: \(lat)")
            print("Longitude: \(long)")
            
        }
    }
    
    func visibilityFormatter(data: Int) -> String {
        var result: Int {
            return data / 1000
        }
        return String(result)
    }
    
    func HectopascalFormatter(data: Double) -> String{
        var hectoPascal: Double {
            return data * 10
        }
        return String(format: "%.0f", hectoPascal)
    }
    
    
}
