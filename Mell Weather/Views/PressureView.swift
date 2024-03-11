    //
    //  PressureView.swift
    //  Mell Weather
    //
    //  Created by Bruna Mello on 11/03/2024.
    //

import SwiftUI
import WeatherKit

struct PressureView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    
    @State private var weather: Weather?
    
    
    var body: some View {
        
        let gradient = Gradient(colors: [.green, .orange, .pink])
        
        VStack {
            if let weather {
                HStack {
                    Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                    Text("PRESSURE")
                        .font(.caption)
                        .opacity(0.8)
                        .foregroundColor(.black)
                }
                Divider()
                VStack {
                    Gauge(value: weather.currentWeather.pressure.value, in: 1...1200) {
                    } currentValueLabel: {
                        Text(weather.currentWeather.pressure.value.rounded().formatted())
                    }                .gaugeStyle(.accessoryCircular)
                        .tint(gradient)
                }
                Text("hPa")
                    .font(.subheadline)
                    .padding(-15)
            }
        }
        .task(id: locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
                    self.weather =  try await weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .frame(width: 150, height: 200)
    }
}

#Preview {
    PressureView()
}
