//
//  TenDaysForecastView.swift
//  Mell Weather
//
//  Created by Bruna Mello on 21/02/2024.
//

import SwiftUI
import CoreLocation
import WeatherKit
import Charts

struct TenDayForcastView: View {
   
    let dayWeatherList: [DayWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10-DAY FORCAST")
                .font(.caption)
                .opacity(0.8)
                .foregroundColor(.black)
            Divider().background(Color.gray)
            List(dayWeatherList, id: \.date) { dailyWeather in
                HStack {
                    Text(dailyWeather.date.formatAsAbbreviatedDay())
                        .frame(maxWidth: 50, alignment: .leading)
                        .foregroundColor(.black)
                    Image(systemName: "\(dailyWeather.symbolName)")
                        .foregroundColor(.orange)
                    Text(dailyWeather.lowTemperature.formatted(.measurement( numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                    Text(dailyWeather.highTemperature.formatted(.measurement( numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.black)
                }
                .listRowBackground(Color.clear)
            }.listStyle(.plain)
        }
        .frame(height: 300).padding()
        .background(content: {
            Color.gray.opacity(0.1)
        })
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}
