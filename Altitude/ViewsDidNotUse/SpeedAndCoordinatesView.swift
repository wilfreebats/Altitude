//
//  SpeedAndCoordinatesView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 1/29/24.
//

import SwiftUI

struct SpeedAndCoordinatesView: View {
    @StateObject var vm = ViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        VStack {
            Text("Your Location")
                .bold()
            
            HStack {
                Text("Latitude: \(vm.coordinates?.lat ?? 0)")
                Text("Longitude: \(vm.coordinates?.long ?? 0)")
            }
            .padding(.bottom ,10)
            
            VStack {
                Text("Speed")
                    .bold()
                    .padding(.bottom, 3)
                
                //Text("Altitude: \(String(format: "%.1f", altitude)) masl")
                Text("Speed: \(String(format: "%.1f", vm.speed?.speed ?? 0)) km/h")
                
                Button("Change appearance") {
                    isDarkMode.toggle()
                }
                .buttonStyle(.borderedProminent)
                .font(.title3)
                .padding(20)
            }
        }
        .onAppear {
            vm.getSpeedAndCoordinates()
        }
        
    }
    

}

#Preview {
    SpeedAndCoordinatesView()
}
