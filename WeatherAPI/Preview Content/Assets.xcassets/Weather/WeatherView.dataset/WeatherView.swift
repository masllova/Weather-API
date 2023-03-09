//
//  WeatherView.swift
//  Weather
//
//  Created by Александра Маслова on 09.03.2023.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
                ZStack {
                    Color(.quaternaryLabel)
                        .ignoresSafeArea()
                    VStack (spacing: 30){
                        VStack {
                            Text("\(TimeZone.current.identifier)")
                                .font(.largeTitle)
                            Text("\(Date().formatted(date: .abbreviated, time: .shortened))")
                                .font(.title2)
                        }
                        .padding()
                        
                        TodayWeatherView()
                        
                        InfStackView()
                            .background(
                                RoundedRectangle(cornerRadius: 25).foregroundColor(.gray).opacity(0.3))
                    }
                }
                .preferredColorScheme(.dark)
            }
            
            struct TodayWeatherView: View {
                var body: some View {
                    VStack {
                        Image(systemName: "sun.max")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(-20)
                        Text("\(9)°")
                            .font(.system(size: 50))
                            .foregroundColor(.black)
                        Text("sun")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical)
                    .frame(width: 180, height: 180)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30).foregroundColor(.white).opacity(0.7).shadow(color: .gray, radius: 10))
                    
                }
            }
            
            
            struct InfStackView: View {
                var body: some View {
                    HStack (spacing: 40){
                        VStack (spacing: 7){
                            Image(systemName: "thermometer.medium")
                            Text("\(12)°")
                        }.font(.title2)
                        VStack (spacing: 7) {
                            Image(systemName: "humidity.fill")
                            Text("\(54)%")
                        }.font(.title2)
                        VStack (spacing: 7) {
                            Image(systemName: "wind")
                            Text("\(5) m/s")
                        }.font(.title2)
                        VStack (spacing: 7) {
                            Image(systemName: "speedometer")
                                .font(.title2)
                            Text("\(989) hPa")
                        }
                    }
                    .padding()
                }
            }
            
        }


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
