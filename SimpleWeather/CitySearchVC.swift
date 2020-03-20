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
    
    private let openWeatherAPIKey = "5138c72c4ed19a1cc943e54e2b2ddb86"
    
    var forecast = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //    private let openWeatherBaseURL = api.openweathermap.org/data/2.5/forecast?q={city name}&appid={your api key}
        
    }
    
    func getWeather() {
        let city = cityField.text
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
//            URLQueryItem(name: "cnt", value: "10"),
            URLQueryItem(name: "appid", value: openWeatherAPIKey)
        ]
        
        let url = components.url
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.forecast = dataDictionary["list"] as! [[String: Any]]
                self.performSegue(withIdentifier: "toForecast", sender: nil)
            }
        }
        task.resume()
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        getWeather()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecast" {
            if let forecastVC = segue.destination as? ForecastVC {
                forecastVC.forecast = forecast
            }
        }
    }
    
    
}

