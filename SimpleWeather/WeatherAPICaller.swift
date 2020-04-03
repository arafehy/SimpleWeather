//
//  WeatherAPICaller.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/16/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import Foundation

class WeatherAPICaller {
    static let sharedInstance = WeatherAPICaller()
    
    private let openWeatherAPIKey = "5138c72c4ed19a1cc943e54e2b2ddb86"
    
    func getWeather(city: String, success: @escaping ([String: Any]) -> (), failure: @escaping (Error) -> ()) {
        // Build the OpenWeatherAPI URL with components
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: openWeatherAPIKey)
        ]
        
        // Get final OpenWeatherAPI URL
        let url = components.url
        
        // Make request to API
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                failure(error)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                success(dataDictionary)
            }
        }
        task.resume()
    }
    
}
