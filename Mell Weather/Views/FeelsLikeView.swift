//
//  FeelsLikeView.swift
//  Mell Weather
//
//  Created by Bruna Mello on 26/02/2024.
//

import SwiftUI
import WeatherKit

struct FeelsLikeView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()

    @State private var weather: Weather?
    
    var body: some View {
        VStack {
            if let weather {
                VStack(alignment: .leading){
                        HStack {
                            Image(systemName: "thermometer.medium")
                            Text("FEELS LIKE")
                        }
                        Divider()
                    Text(weather.currentWeather.temperature.formatted(.measurement( numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .font(.system(size: 50))
                        .bold()
                }
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
    FeelsLikeView()
}
