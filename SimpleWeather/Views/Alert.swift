//
//  Alert.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/22/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import Foundation
import UIKit

/// A struct containing functions to show alerts.
struct Alert {
    
    /// Presents an alert when the city field is empty and submit is clicked.
    /// - Parameter on: The view controller where the alert should appear.
    func showEmptyCityAlert(on: UIViewController) {
        // Show user alert that city must be provided
        let alertController = UIAlertController(title: "No City Provided",
                                                message: "Please enter a valid city.",
                                                preferredStyle: .alert)
        
        // Create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // Add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            on.present(alertController, animated: true)
        }
    }
    
    /// Presents an alert when a city is not found on OpenWeatherMap.
    /// - Parameters:
    ///   - city: The city requested by the user.
    ///   - on: The view controller where the alert should appear.
    func showCityNotFoundAlert(city: String, on: UIViewController) {
        // Show user alert that city provided was not found
        let alertController = UIAlertController(title: "City Not Found",
                                                message: "\(city) not found. Please enter a valid city.",
            preferredStyle: .alert)
        
        // Create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // Add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            on.present(alertController, animated: true)
        }
    }
    
    /// Presents an alert when an error occurs getting the forecast from OpenWeatherMap.
    /// - Parameter on: The view controller where the alert should appear.
    func showUnknownProblemAlert(on: UIViewController) {
        // Show user alert that an unknown error occured
        let alertController = UIAlertController(title: "An error occurred",
                                                message: "Sorry. There was a problem connecting. Please check your connection and try again.",
                                                preferredStyle: .alert)
        
        // Create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // Add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            on.present(alertController, animated: true)
        }
    }
}
