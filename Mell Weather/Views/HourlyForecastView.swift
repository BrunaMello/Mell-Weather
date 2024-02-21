//
//  HourlyForecastView.swift
//  Mell Weather
//
//  Created by Bruna Mello on 21/02/2024.
//

import SwiftUI
import CoreLocation
import WeatherKit
import Charts

struct HourlyForcastView: View {
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("HOURLY FORECAST")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 20) {
                            Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .foregroundColor(.yellow)
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.medium)
                        }.padding()
                    }
                }
            }
        }.padding().background {
            Color.blue
        }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .foregroundColor(.white)
    }
}
