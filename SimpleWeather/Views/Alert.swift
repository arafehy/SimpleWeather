//
//  Alert.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/22/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
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
