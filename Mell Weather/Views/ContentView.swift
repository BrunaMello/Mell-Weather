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
        ScrollView(.vertical) {
            if let weather {
                VStack {
                    VStack {
                        CurrentWeatherView()
                        HourlyForcastView(hourWeatherList: hourlyWeatherData)
                            .padding(.bottom, 20)
                            // HourlyForecastChartView(hourlyWeatherData: hourlyWeatherData)
                        TenDayForcastView(dayWeatherList: weather.dailyForecast.forecast)
                    }
                    
                    HStack {
                        FeelsLikeView()
                        Spacer()
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

