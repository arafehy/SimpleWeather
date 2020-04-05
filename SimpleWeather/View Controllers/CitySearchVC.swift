//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/16/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import UIKit

/// The initial view controller used to get the forecast for a city.
class CitySearchVC: UIViewController {
    
    /// The text field to enter the name of a city.
    @IBOutlet weak var cityField: UITextField!
    /// The submit button.
    @IBOutlet weak var submitButton: UIButton!
    
    /// The weather forecast obtained from OpenWeatherMap API.
    var forecast = [[String: Any]]()
    /// The shared instance of WeatherAPICaller.
    let weather = WeatherAPICaller.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round corners for submit button
        submitButton.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        cityField.text = ""
        cityField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    /// Gets the weather forecast and shows alerts for empty city field, city not found, and other errors (i.e. no internet connection)
    func getWeather() {
        let city = cityField.text ?? ""
        guard !city.isEmpty else {
            let alert = Alert()
            alert.showEmptyCityAlert(on: self)
            return
        }
        
        weather.getWeather(city: city, success: { (dataDictionary) in
            if let forecastDictionary = dataDictionary["list"] as? [[String: Any]] {
                self.forecast = forecastDictionary
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toForecast", sender: nil)
                }
            }
            else {
                let alert = Alert()
                alert.showCityNotFoundAlert(city: city, on: self)
            }
        }) { (error) in
            let alert = Alert()
            alert.showUnknownProblemAlert(on: self)
        }
    }
    
    /// Calls getWeather() when the submit button is pressed.
    /// - Parameter sender: The submit button below the city field.
    @IBAction func onSubmit(_ sender: UIButton) {
        getWeather()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecast" {
            if let forecastVC = segue.destination as? ForecastVC {
                forecastVC.forecast = forecast
                let city = cityField.text?.capitalized ?? "Random"
                forecastVC.navigationItem.title = "\(city) Forecast"
            }
        }
    }
    
}
