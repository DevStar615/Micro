//
//  MenuTvCell.swift
//  Pump Manage
//
//  Created by mac on 23/08/18.
//

import UIKit

class MenuTvCell: UITableViewCell {

    @IBOutlet weak var lblMenuTitle: UILabel!
    @IBOutlet weak var vwSelected: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        vwSelected.backgroundColor = selected ? UIColor.yellow : UIColor.clear
        lblMenuTitle.textColor = selected ? UIColor.yellow : UIColor.white
    }
    
}
