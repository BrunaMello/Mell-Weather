import SwiftUI
import CoreLocation
import WeatherKit
import Charts

struct ContentView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    
    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    var body: some View {
        VStack {
            if let weather {
                VStack {
                    Text("San Francisco")
                        .font(.largeTitle)
                    Text("\(weather.currentWeather.temperature.formatted())")
                }
                HourlyForcastView(hourWeatherList: hourlyWeatherData)
                    //  Spacer()
                HourlyForecastChartView(hourlyWeatherData: hourlyWeatherData)
                TenDayForcastView(dayWeatherList: weather.dailyForecast.forecast)
            }
        }
        .padding()
        .task(id: locationManager.currentLocation) {
            do {
                    // if let location = locationManager.currentLocation {
                let location = CLLocation(latitude: 37.774929, longitude: -122.419418)
                self.weather =  try await weatherService.weather(for: location)
                    // }
            } catch {
                print(error)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
