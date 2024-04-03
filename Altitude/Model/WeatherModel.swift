//
//  WeatherModel.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/2/24.
//

import Foundation

struct WeatherModel: Codable {
    let wind: Wind
    let weather: [Weather]
    let visibility: Int
    let main: Main
    let sys: Sys
    let name: String
    
    //static var sampleData = WeatherModel(coord: Coord(lon: 0, lat: 0), wind: Wind(speed: 0, deg: 0, gust: 0), weather: [Weather], main: Main(temp_min: 0, temp_max: 0), name: "--")
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
