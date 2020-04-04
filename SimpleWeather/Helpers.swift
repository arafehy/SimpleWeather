//
//  Helper.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 4/2/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import Foundation

class Helpers {
    static func getDayOfWeek(_ date:String) -> String {
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
}
