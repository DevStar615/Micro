//
//  pumpRatingCell.swift
//  Pump Manage
//
//  Created by LaNet on 21/08/18.
//

import UIKit

class pumpRatingCell: UITableViewCell {

    @IBOutlet weak var ratingVw: RatingControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
