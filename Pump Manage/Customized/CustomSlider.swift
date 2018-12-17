//
//  CustomSlider.swift
//  Pump Manage
//
//  Created by mac on 28/08/18.
//

import UIKit

class CustomSlider: UISlider {
    @IBInspectable open var trackWidth:CGFloat = 5 {
        didSet {setNeedsDisplay()}
    }
    
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
            width: defaultBounds.size.width,
            height: trackWidth
        )
    }

}
