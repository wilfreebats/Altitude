//
//  BarometerView.swift
//  Altitude
//
//  Created by Wilfredo Batucan on 4/1/24.
//

import SwiftUI

struct BarometerView: View {
    @EnvironmentObject var vm: AltitudeViewModel
    
    @State private var current = 67.0
    @State private var minValue = 0.0
    @State private var maxValue = 180.0
    let gradient = Gradient(colors: [.blue, .green, .yellow, .orange, .red])

    var body: some View {
        NavigationStack {
            VStack {
                Gauge(value: vm.baromemter?.barometer ?? 0, in: minValue...maxValue) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                } currentValueLabel: {
                    Text("\(Int(vm.baromemter?.barometer ?? 0))")
                        .foregroundColor(Color.green)
                    
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                        .foregroundColor(Color.green)
                } maximumValueLabel: {
                    Text("\(Int(maxValue))")
                        .foregroundColor(Color.red)
                }
                .tint(gradient)
                .gaugeStyle(.accessoryCircular)
                .scaleEffect(3.0)

            }
            .padding(.bottom, 50)
            
            VStack {
                Text("Current atmospheric pressure (kPa)")
                    .font(.system(size: 15))
                    .fontWeight(.heavy)
            }
            .padding(.top, 20)
            
            
            .navigationTitle("Barometer")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct BarometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)
    
    private var gradient = Gradient(colors: [.blue, .green, .yellow, .orange, .red])
 
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
 
            Circle()
                .foregroundColor(Color(.systemGray6))
 
            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                //.stroke(gradient, lineWidth: 20)
                .stroke(gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(135))
 
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 34], dashPhase: 0.0))
                .rotationEffect(.degrees(135))
 
            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text("KM/H")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.gray)
            }
 
        }
        .frame(width: 300, height: 300)
 
    }
 
}


struct CustomGaugeStyle: GaugeStyle {
    let lineWidth: CGFloat = 6
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(
                    .tint.opacity(0.4),
                    style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: -0.3, to: 0.75 * configuration.value)
                .stroke(
                    .tint,
                    style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(.degrees(135))
            
            configuration.currentValueLabel
                .padding(.horizontal, lineWidth)
        }
        .padding(lineWidth/2)
        .overlay(alignment: .bottom) {
            configuration.label
                .padding(.horizontal, lineWidth * 2)
        }
    }
}

#Preview {
    BarometerView()
}
