//
//  EmailConfirmationVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 18/08/18.
//

import UIKit

class EmailConfirmationVC: BaseViewController {

    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:Button IBActions
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
     //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
