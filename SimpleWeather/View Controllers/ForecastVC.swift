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
    let weatherIconsCache = NSCache<NSString, UIImage>()
    let weather = WeatherAPICaller.sharedInstance
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.isHidden = false
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell") as? DayCell else {
            return UITableViewCell()
        }
        
        // Since API returns weather every 3 hours, I am retrieving the weather every 24 hours from the first entry in the dictionary
        var day = forecast[0]
        if indexPath.row != 0 {
            day = forecast[indexPath.row * 8]
        }
        guard let weather = day["weather"] as? [[String: Any]] else {
            return UITableViewCell()
        }
        let innerWeather = weather[0]
        
        // Get weather description
        guard let description = innerWeather["description"] as? String else {
            return UITableViewCell()
        }
        cell.weatherDescriptionLabel.text = description.capitalized
        
        // Get date
        guard let dateTime = day["dt_txt"] as? String else {
            return UITableViewCell()
        }
        let date = dateTime.prefix(10)
        
        // Set cell label to day of week
        let dayOfWeek = Helpers.getDayOfWeek(String(date))
        cell.dayOfWeekLabel.text = dayOfWeek
        
        // Set weather icon
        let iconID = innerWeather["icon"] as! String
        let urlString = "https://openweathermap.org/img/wn/\(iconID)@2x.png"
        guard let url = URL(string: urlString) else {
            return UITableViewCell()
        }
        if let cachedIcon = weatherIconsCache.object(forKey: url.absoluteString as NSString) {
            cell.weatherIcon.image = cachedIcon
        }
        else {
            cell.weatherIcon.getIcon(url: url)
        }
        
        return cell
    }
    
}


extension UIImageView {
    func getIcon(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
