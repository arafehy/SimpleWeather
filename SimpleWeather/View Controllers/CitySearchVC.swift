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
    
    var forecast = [[String: Any]]()
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
