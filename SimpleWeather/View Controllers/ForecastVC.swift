//
//  ForecastVC.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/19/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var forecast = [[String: Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func getDayOfWeek(_ date:String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: date) else { return "Not a date" }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        switch weekDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        default:
            return "Saturday"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell") as! DayCell
        
        // Since API returns weather every 3 hours, I am retrieving the weather every 24 hours from the first entry in the dictionary
        var day = forecast[0]
        if indexPath.row != 0 {
            day = forecast[indexPath.row * 8]
        }
        let weather = day["weather"] as! [[String: Any]]
        let innerWeather = weather[0]
        
        // Get weather icon
        let iconID = innerWeather["icon"] as! String
        let urlString = "https://openweathermap.org/img/wn/\(iconID)@2x.png"
        let weatherIconURL = URL(string: urlString)
        let data = try? Data(contentsOf: weatherIconURL!)
        
        // Set weather icon
        if let imageData = data {
            cell.weatherIcon.image = UIImage(data: imageData)
        }
        
        // Get weather description
        let description = innerWeather["description"] as! String
        cell.weatherDescriptionLabel.text? = description.capitalized
        
        // Get date
        let dateTime = day["dt_txt"] as? String
        let date = dateTime?.prefix(10)
        
        // Set cell label to day of week
        let dayOfWeek = getDayOfWeek(String(date!))
        cell.dayOfWeekLabel.text = dayOfWeek
        
        return cell
    }
    
}
