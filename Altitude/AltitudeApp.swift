//
//  AltitudeApp.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/25/24.
//

import SwiftUI

@main
struct AltitudeApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject var dataProvider = AltitudeViewModel()
    @StateObject var weatherData = DataViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(.dark)
            
                .environmentObject(dataProvider)
                .environmentObject(weatherData)
        }
    }
}
