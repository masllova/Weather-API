//
//  Model.swift
//  WeatherAPI
//
//  Created by Александра Маслова on 07.03.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    //optional тк мы запрашиваем доступ к локации
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    func requestLocation () {
        isLoading = true
        manager.requestLocation()
    }
    // for CLLocationManagerDelegate:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
        isLoading = false
    }
    
}

class WeatherManager {
    func getCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=83eab01d5fe1855e5252cd5c45abe9f7&units=metric") else {fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
       let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Data error")}
        
       let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

var previewWeather: ResponseBody = load("FakeDataToPreviews.json")
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
