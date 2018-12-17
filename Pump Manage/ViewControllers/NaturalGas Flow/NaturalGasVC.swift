//
//  NaturalGasVC.swift
//  Pump Manage
//
//  Created by mac on 07/09/18.
//

import UIKit

class NaturalGasVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblComingSoon: UILabel!
    @IBOutlet weak var vwTop: UIView!
    
    var lblTitleText:String?
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        lblTitle.text = lblTitleText
        lblService.text = lblTitleText! + " Service"
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Custom Function
    func design(){
        lblComingSoon.textColor = AppColor.backgroundColor
        vwTop.backgroundColor = AppColor.backgroundColor        
    }
    
    //MARK:- Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
