//
//  BaseViewController.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 18/08/18.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    
    let reachability = Reachability()!

    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = AppColor.backgroundColor
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    //InterNet Notification Method
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            showToastMessage(internetCheck)
        }
    }
    
    //MARK: Common Api Call
    func SendOtp(type:String){
        let otpDict:NSMutableDictionary = NSMutableDictionary()
        otpDict.setValue(appDelegate?.customerModel.id, forKey: "id")
        otpDict.setValue(type, forKey: "type")
        
        APIService.sharedInstance.makeCall(requestMethod: "POST", apiName: otp, params: otpDict, forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                }else{
                    let msg:String = response as! String
                    showToastMessage(msg)
                }
            }
        }) { (error) in
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
    
    //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
