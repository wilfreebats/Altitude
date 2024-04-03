//
//  TabBarView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/1/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: Tab = .altitude
    
    enum Tab {
        case altitude
        case barometer
        case data
    }
    
    var body: some View {
        TabView {
            AltitudeView()
                .tabItem {
                    Label("Altitude", systemImage: "mountain.2.circle.fill")
                }
                .tag(Tab.altitude)
            
            BarometerView()
                .tabItem {
                    Label("Barometer", systemImage: "barometer")
                }
                .tag(Tab.barometer)
            
            DataView()
                .tabItem {
                    Label("Data", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.barometer)
        }
    }
}

#Preview {
    TabBarView()
}
