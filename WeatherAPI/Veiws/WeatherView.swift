//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by Александра Маслова on 07.03.2023.
//

import SwiftUI

struct WeatherView: View {
    var data: ResponseBody
    
    var body: some View {
        ZStack {
            Color(.quaternaryLabel)
                .ignoresSafeArea()
            VStack (spacing: 30){
                VStack {
                    Text("\(TimeZone.current.identifier)")
                        .font(.system(size: 40))
                    Text("\(Date().formatted(date: .abbreviated, time: .shortened))")
                        .font(.system(size: 25))
                }
                
                TodayWeatherView(data: data)
                
                InfStackView(data: data)
                    .background(
                        RoundedRectangle(cornerRadius: 25).foregroundColor(.gray).opacity(0.3).shadow(color: .gray,radius: 7))
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct TodayWeatherView: View {
    var data: ResponseBody
    var body: some View {
        VStack {
            Image("\(data.weather[0].icon)")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(-20)
            Text("\(data.main.temp.roundDouble())°")
                .font(.system(size: 60))
                .foregroundColor(.black)
            Text(data.weather[0].description)
                .font(.title)
                .foregroundColor(.black)
        }
        .padding(.vertical)
        .frame(width: 200, height: 250)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25).foregroundColor(.white).opacity(0.5).shadow(color: .gray, radius: 10))
        
    }
}

struct InfStackView: View {
    var data: ResponseBody
    var body: some View {
        HStack (spacing: 40){
            VStack (spacing: 7){
                Image(systemName: "thermometer.medium")
                Text("\(data.main.feelsLike.roundDouble())°")
            }.font(.title)
            VStack (spacing: 7) {
                Image(systemName: "humidity.fill")
                Text("\(data.main.humidity.roundDouble())%")
            }.font(.title2)
            VStack (spacing: 7) {
                Image(systemName: "wind")
                Text("\(data.wind.speed.roundDouble()) m/s")
            }.font(.title2)
            VStack (spacing: 7) {
                Image(systemName: "speedometer")
                    .font(.title2)
                Text("\(data.main.pressure.roundDouble()) hPa")
                    .padding(.vertical, 6)
            }
        }
        .padding(.horizontal)
        .padding()
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(data: previewWeather)
    }
}
