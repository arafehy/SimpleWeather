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
    let weather = WeatherAPICaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Round corners for submit button
        submitButton.layer.cornerRadius = 4
    }
    
    func getWeather() {
        let city = cityField.text ?? ""
        guard !city.isEmpty else {
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
        
        weather.getWeather(city: city, success: { (dataDictionary) in
            DispatchQueue.main.async {
                if let forecastDictionary = dataDictionary["list"] as? [[String: Any]] {
                    self.forecast = forecastDictionary
                    self.performSegue(withIdentifier: "toForecast", sender: nil)}
            }
        }) { (error) in
            // Show user alert that city provided was not found
            let alertController = UIAlertController(title: "City Not Found",
                                                    message: "\(city) not found. Please enter a valid city.",
                preferredStyle: .alert)
            
            // Create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default)
            // Add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true)
        }
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
