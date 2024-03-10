    //
    //  WindView.swift
    //  Mell Weather
    //
    //  Created by Bruna Mello on 10/03/2024.
    //

import SwiftUI
import WeatherKit

struct WindView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    
    @State private var weather: Weather?
    
    
    var body: some View {
        VStack {
            if let weather {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "wind")
                        Text("WIND")
                            .font(.caption)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                    }
                    Divider()
                    HStack {
                        HStack {
                            
                            VStack(alignment: .center) {
                                Text(weather.currentWeather.wind.speed.formatted())
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .bold()
                                Text("Wind")
                                    .font(.subheadline)
                                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                            Divider()
                            Spacer()
                            
                            VStack(alignment: .center) {
                                Text((weather.currentWeather.wind.gust?.formatted())!)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .bold()
                                Text("Gusts")
                                    .font(.subheadline)
                                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            }
                            
                        }
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
        .frame(width: 350, height: 150)
        
    }
}

#Preview {
    WindView()
}
