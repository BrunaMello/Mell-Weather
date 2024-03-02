    //
    //  UvIndexView.swift
    //  Mell Weather
    //
    //  Created by Bruna Mello on 02/03/2024.
    //

import SwiftUI
import WeatherKit
import CoreLocation

struct UvIndexView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    
    @State private var weather: Weather?
    
    var exposureCategory: String {
        let uvCategory = weather?.currentWeather.uvIndex.category
        switch uvCategory {
            case .extreme: return "The UV index is extreme."
            case .high: return "The UV index is high."
            case .low: return "The UV index is low."
            case .moderate: return "The UV index is moderate."
            case .veryHigh: return "The UV index is very high."
            case .none: return "The UV index is none."
        }
    }
    
    var body: some View {
        VStack {
            if let weather {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Text("UV INDEX")
                            .font(.caption)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                    }
                    Divider()
                    HStack {
                        Text(weather.currentWeather.uvIndex.value.description)
                            .font(.system(size: 50))
                            .bold()
                        Spacer()
                        Text(exposureCategory)
                            .font(.subheadline)
                    }
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
    UvIndexView()
}
