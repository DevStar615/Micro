//
//  SliderThumb.swift
//  Pump Manage
//
//  Created by mac on 28/08/18.
//

import UIKit


class SliderThumb: UIView {
    
    let lblValue = UILabel()

    init(frame: CGRect,value:String) {
        super.init(frame: frame)
        createThumView(value:value)
    }
    
    func createThumView(value:String){
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        self.backgroundColor = AppColor.backgroundColor
        self.layer.cornerRadius = 15
        self.lblValue.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        self.lblValue.textColor = UIColor.white
        self.lblValue.text = value
        self.lblValue.font = UIFont(name: AppFont.montSerratFont, size: 13)
        self.lblValue.textAlignment = .center
        self.addSubview(lblValue)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
