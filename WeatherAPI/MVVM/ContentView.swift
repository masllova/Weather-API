//
//  ContentView.swift
//  WeatherAPI
//
//  Created by Александра Маслова on 05.03.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        ZStack {
            Color(.quaternaryLabel)
                .ignoresSafeArea()
            
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(data: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                               weather = try await weatherManager.getCurrentWeather(lat:  location.latitude, lon: location.longitude)
                            } catch {
                                print("error getting data \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                   LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
