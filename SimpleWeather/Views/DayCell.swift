//
//  DayCell.swift
//  SimpleWeather
//
//  Created by Yazan Arafeh on 3/19/20.
//  Copyright © 2020 Arafeh. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
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
