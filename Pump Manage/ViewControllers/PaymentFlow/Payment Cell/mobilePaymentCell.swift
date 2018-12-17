//
//  pumpDetailsCell.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 22/08/18.
//

import UIKit

class mobilePaymentCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- Custom Method
    func expand() {
        mainView.isHidden = true
        subView.isHidden = false
    }
    
    func collapse() {
        mainView.isHidden = false
        subView.isHidden = true
    }
}
