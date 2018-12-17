//
//  pumpDetailsTblCellLike.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 21/08/18.
//

import UIKit

class pumpDetailsTblCellLike: UITableViewCell {

    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var dislikeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeView.likeDislikeView(rect: likeView.frame)
        dislikeView.likeDislikeView(rect: dislikeView.frame)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
