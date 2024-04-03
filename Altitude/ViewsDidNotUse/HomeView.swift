//
//  SpeedView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/26/24.
//

import SwiftUI
import CoreLocation
import CoreMotion

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            AltitudeView()
                .padding(20)
            SpeedAndCoordinatesView()
            
            .navigationTitle("My Altitude")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
  
}

#Preview {
    HomeView()
}
