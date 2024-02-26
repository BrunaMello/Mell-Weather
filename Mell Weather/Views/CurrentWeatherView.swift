//
//  CurrentWeatherView.swift
//  Mell Weather
//
//  Created by Bruna Mello on 26/02/2024.
//

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    
    var body: some View {
        VStack{
            if let weather {
                HStack {
                    Image(systemName: weather.currentWeather.symbolName)
                        .resizable()
                        .frame(width: 100, height: 90)
                    VStack {
                        Text(locationManager.placeName)
                            .font(.system(size: 40))
                            .fontWeight(.regular)
                        Text(weather.currentWeather.temperature.formatted(.measurement( numberFormatStyle: .number.precision(.fractionLength(0)))))
                            .font(.system(size: 80))
                            .fontWeight(.heavy)
                        Text(weather.currentWeather.condition.description)
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                }
            }
        }
        .padding()
        .task(id: locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
                    self.weather =  try await weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
        }
    }
}
