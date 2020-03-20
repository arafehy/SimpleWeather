//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/16/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import UIKit

class CitySearchVC: UIViewController {
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private let openWeatherAPIKey = "5138c72c4ed19a1cc943e54e2b2ddb86"
    
    var forecast = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Round corners for submit button
        submitButton.layer.cornerRadius = 4
    }
    
    func getWeather() {
        let city = cityField.text
        guard !city!.isEmpty else {
            // Show user alert that city must be provided
            let alertController = UIAlertController(title: "No City Provided",
                                                    message: "Please enter a valid city.",
                                                    preferredStyle: .alert)
            
            // Create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default)
            // Add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true)
            return
        }
        
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
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let forecastDictionary = dataDictionary["list"] as? [[String: Any]] {
                    self.forecast = forecastDictionary
                    self.performSegue(withIdentifier: "toForecast", sender: nil)
                } else {
                    // Show user alert that city provided was not found
                    let alertController = UIAlertController(title: "City Not Found",
                                                            message: "\(city!) not found. Please enter a valid city.",
                                                            preferredStyle: .alert)
                    
                    // Create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    // Add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true)
                }
            }
        }
        task.resume()
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        getWeather()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecast" {
            if let navigationController = segue.destination as? UINavigationController {
                if let forecastVC = navigationController.topViewController as? ForecastVC {
                    forecastVC.forecast = forecast
                    let city = cityField.text?.capitalized
                    forecastVC.navigationItem.title = "\(city ?? "Random") Forecast"
                }
            }
        }
    }
    
    
}

