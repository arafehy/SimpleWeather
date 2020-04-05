//
//  WeatherAPICaller.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/16/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import Foundation

/// A class used to make API calls to OpenWeatherAPI.
class WeatherAPICaller {
    /// The shared instance of WeatherAPICaller to be used throughout the app.
    static let sharedInstance = WeatherAPICaller()
    
    /// The private OpenWeatherMap API key.
    private let openWeatherAPIKey = "5138c72c4ed19a1cc943e54e2b2ddb86"
    
    /// Build the OpenWeatherAPI URL for a city with components.
    /// - Parameter city: The city requested by the user.
    /// - Returns: The URL to make the request.
    func buildURL(city: String) -> URL {
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
        return components.url!
    }
    
    /// Get the weather forecast for a city from OpenWeatherMap
    /// - Parameters:
    ///   - city: The city requested by the user.
    ///   - success: A closure which is called if a dictionary JSON is received.
    ///   - dictionary: The forecast dictionary.
    ///   - failure: A closure which is called if an error occurs.
    ///   - error: The error that occurred.
    /// - Returns: The dictionary received from the API, or the error that occurred.
    func getWeather(city: String, success: @escaping (_ dictionary: [String: Any]) -> (), failure: @escaping (_ error: Error) -> ()) {
        let url = buildURL(city: city)
        
        // Make request to API
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
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
