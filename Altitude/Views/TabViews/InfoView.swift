//
//  InfoView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/2/24.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                
                HStack(alignment: .center, content: {
                    Text("Information and current weather data is based on weather data from your local weather station (if available).")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "speedometer")
                        .resizable()
                        .frame(width: 35, height: 30)
                  
                    Text("Current atmospheric pressure (hPa) in the place where you are.")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "mountain.2.fill")
                        .resizable()
                        .frame(width: 35, height: 30)
                        
                    Text("Current altitude (masl) in the place where you are.")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "thermometer.medium")
                        .resizable()
                        .frame(width: 35, height: 40)
               
                    Text("Outside Temperature (°C).")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "wind.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 30)
               
                    Text("Wind speed (kph).")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "eye.fill")
                        .resizable()
                        .frame(width: 35, height: 30)
               
                    Text("Visibility (km).")
                })
                .padding()
                
                HStack(alignment: .center, content: {
                    Image(systemName: "humidity.fill")
                        .resizable()
                        .frame(width: 35, height: 30)
               
                    Text("Humidity (%).")
                })
                .padding()
            }
            
            .navigationTitle("Data Information")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("OK")
                            .bold()
                    })
                }
            }
        }
    }
}

#Preview {
    InfoView()
}
