//
//  DayCell.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/19/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import UIKit

/// The table view cell to display the forecast for a day.
class DayCell: UITableViewCell {
    
    /// The forecast's weather icon.
    @IBOutlet weak var weatherIcon: UIImageView!
    /// The label for the day of the week.
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    /// The label for the description of the forecast.
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
