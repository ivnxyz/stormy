//
//  WeatherAPIClient.swift
//  Stormy
//
//  Created by Iván Martínez on 24/09/17.
//  Copyright © 2017 Iván Martínez. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherAPIClient {
    
    fileprivate let apiKey = "c64116987dab74f6c6eb9b618aa83a8b"
    
    lazy var baseURL: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
    }()
    
    func getWeather(for location: CLLocation) {
        let locationDescription = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        guard let url = URL(string: locationDescription, relativeTo: baseURL) else { return }
        
        let request = URLRequest(url: url)
    }
}
