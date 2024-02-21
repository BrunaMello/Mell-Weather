//
//  HourlyForecastChartView.swift
//  Mell Weather
//
//  Created by Bruna Mello on 21/02/2024.
//

import SwiftUI
import CoreLocation
import WeatherKit
import Charts

struct HourlyForecastChartView: View {
    let hourlyWeatherData: [HourWeather]
    
    var body: some View {
        Chart {
            ForEach(hourlyWeatherData.prefix(10), id: \.date) { hourlyWeather in
                LineMark(x: .value("Hour", hourlyWeather.date.formatAsAbbreviatedTime()), y: .value("Temperature", hourlyWeather.temperature.converted(to: .fahrenheit).value))
            }
        }
    }
}
