//
//  DayCell.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/20/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

// Step 6: add protocol
protocol DayCellDelegate: class {
    func cellTapped(_ section: Int)
}

class DayCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    // Step 6: add delegate, section, and expanded
    weak var delegate: DayCellDelegate?
    var section: Int!
    var expanded = false

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Step 6: add setupCell function
    func setupCell(_ day: String, temp: String, section: Int, expanded: Bool) {
        dayLabel.text = day
        tempLabel.text = temp
        self.section = section
        self.expanded = expanded
        self.arrowImage.transform = CGAffineTransform(rotationAngle: self.expanded ? CGFloat(M_PI) : 0.0)
    }
    
    // Step 6: implement cellTapped
    @IBAction func cellTapped(_ sender: AnyObject) {
        expanded = !expanded
        delegate?.cellTapped(section)
    }
}
