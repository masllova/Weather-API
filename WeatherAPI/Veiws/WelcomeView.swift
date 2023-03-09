//
//  WelcomeView.swift
//  WeatherAPI
//
//  Created by Александра Маслова on 08.03.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Welcome to the Weather App")
                    .bold().font(.title2)
                Text("Please share your current location to get your weather in your area")
            }.multilineTextAlignment(.center)
                .padding(.horizontal)
            VStack {
                Spacer()
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(20)
                .foregroundColor(.white)
            }.padding(.bottom, 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
