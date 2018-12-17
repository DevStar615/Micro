//
//  MobilePaymentVC.swift
//  Pump Manage
//
//  Created by LaNet on 21/08/18.
//

import UIKit

class PaymentSuccesVC: UIViewController {

    @IBOutlet weak var VwSuccessImg: UIView!
    @IBOutlet weak var VwPayment: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //VwPayment.layer.cornerRadius = 10
        //VwPayment.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        //VwPayment.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //VwPayment.layer.shadowOpacity = 1.0
        //VwPayment.layer.shadowRadius = 6.0
        
        VwSuccessImg.layer.cornerRadius = 60.0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
