//
//  DataView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/1/24.
//

import SwiftUI

struct DataView: View {
    @StateObject private var vm = DataViewModel()
    @EnvironmentObject var dependency: AltitudeViewModel
    
    @State private var showInfo = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.center) {
                    HStack(alignment: .center) {
                        Text("\(vm.weather?.main.grndLevel ?? 0)")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                        
                        Text("hPa")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                    }
                    
                    HStack(alignment: .center) {
                        Text(String(format: "%.1f", dependency.altitude?.altitude ?? 0))
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                        
                        Text("MASL")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal)
                
                VStack(alignment:.center) {
                    HStack(alignment: .center) {
                        Image(systemName: "thermometer.medium")
                            .font(.system(size: 50))
                        
                        Text("\(String(format: "%.1f", vm.weather?.main.temp ?? 0))°")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                        
                        Text("C ")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                    }
                    Divider()
                }
                .padding(.top, 15)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20, content: {
                    Text("Other info:")
                        .bold().padding(.bottom)
                    
                    HStack {
                        Image(systemName: "wind.circle.fill")
                            .font(.system(size: 30))
                        
                        VStack(alignment: .leading, content: {
                            Text("Wind speed")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                            
                            Text("\(String(format: "%.1f", vm.weather?.wind.speed ?? 0))km/h")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        })
                        
                        Spacer()
                        
                        Image(systemName: "eye.fill")
                            .font(.system(size: 30))
                        
                        VStack(alignment: .leading, content: {
                            Text("Visibility")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                            
                            Text("\(vm.visibilityFormatter(data: vm.weather?.visibility ?? 0)) km")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        })
                    }
                    
                    HStack {
                        Image(systemName: "humidity.fill")
                            .font(.system(size: 30))
                        
                        VStack(alignment: .leading, content: {
                            Text("Humidity")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                            
                            Text("\(vm.weather?.main.humidity ?? 0)%")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        })
                        
                        Spacer()
                        
                        Image(systemName: "thermometer.low")
                            .font(.system(size: 30))
                        
                        VStack(alignment: .leading, content: {
                            Text("Min temp")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                            
                            Text("\(String(format: "%.1f", vm.weather?.main.tempMin ?? 0))°C")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        })
                    }
                })
                .frame(maxWidth: 310, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(20)
                
            }
            .refreshable {
                do {
                    try await vm.fetchWeatherData(latitude: vm.coordinates!.lat, longitude: vm.coordinates!.long)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            .onAppear(perform: {
                vm.getCoordinates()
            })
            
            .task {
                do {
                    try await vm.fetchWeatherData(latitude: vm.coordinates!.lat, longitude: vm.coordinates!.long)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            .navigationTitle("Data")
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInfo.toggle()
                    } label: {
                        Label("Info", systemImage: "info.circle.fill")
                    }

                }
            }
            
            .sheet(isPresented: $showInfo, content: {
                InfoView().presentationDetents([.large])
            })
        }
    }
}

#Preview {
    DataView()
}
