//
//  StationTableViewCell.swift
//  Corona-App
//
//  Created by BB1151 on 16.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var stationHeaderLabel: UILabel!
    @IBOutlet weak var stattionAdressLabel: UILabel!
    @IBOutlet weak var stationDestinationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
