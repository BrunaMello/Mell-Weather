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
                .opacity(0.8)
                .foregroundColor(.black)
            Divider().background(Color.gray)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 20) {
                            Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                            Image(systemName: "\(hourWeatherItem.symbolName)")
                                .foregroundColor(.orange)
                            Text(hourWeatherItem.temperature.formatted(.measurement( numberFormatStyle: .number.precision(.fractionLength(0)))))
                                .fontWeight(.medium)
                        }.padding()
                    }
                }
            }
        }.padding().background {
            Color.gray.opacity(0.1)
        }.clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}

