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
//        print(forecast)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell") as! DayCell
        
        let day = forecast[indexPath.row]
        let weather = day["weather"] as! [[String: Any]]
        let innerWeather = weather[0]
        let description = innerWeather["description"] as! String
        cell.weatherDescriptionLabel.text = description
        
        let dateTime = day["dt_txt"] as? String
        let date = dateTime?.prefix(10)
        
        // Set cell label to day of week
        let dayOfWeek = getDayOfWeek(String(date!))
        cell.dayOfWeekLabel.text = dayOfWeek
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}