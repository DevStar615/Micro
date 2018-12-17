//
//  OtpVC.swift
//  Pump Manage
//
//  Created by mac on 31/08/18.
//

import UIKit

class OtpVC: BaseViewController {
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var lblGetCode: UILabel!
    @IBOutlet weak var txtSms: UITextField!
    @IBOutlet weak var lblWelcome:UILabel!
    @IBOutlet weak var lblSmsTitle: UILabel!
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwMain: UIView!
    
    var type:String!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnResendClicked(_ sender: Any) {
        self.SendOtp(type: type)
    }
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        verifyOtp()
    }
    
    //MARK:-  Custom function
    func design() {
        view.backgroundColor = AppColor.appColor
        vwTop.backgroundColor = AppColor.backgroundColor
        txtSms.applyPlacHolder(placeHolderText: "", color: AppColor.loginTextPlaceHolerColor)
         
        lblResend.setSubTitleLabel(title: resend)
        lblGetCode.setSubTitleLabel(title: didntGetCode)
        btnConfirm.appButton(title: confirm)
        
        type == emailType ?  lblSmsTitle.setSubTitleLabel(title: emailConfirmationCode) : lblSmsTitle.setSubTitleLabel(title: smsConfirmationCode)
        lblWelcome.text = welcometo
        lblTerms.text = otpTerms
    }
    
    //MARK:-  Api Call
    func verifyOtp(){
        let params = NSMutableDictionary()
        params.setValue(appDelegate?.customerModel.id, forKey: "id")
        params.setValue(txtSms.text, forKey: "otp")
        APIService.sharedInstance.makeCall(requestMethod: "GET", apiName: otpVerification, params: params, isTokenRequired: true, forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    self.txtSms.resignFirstResponder()
                    showToastMessage(error!)
                }else{
                    if(response != nil) {
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: UserDefaultsKey.loggedInKey)
                        defaults.synchronize()
                        self.txtSms.resignFirstResponder()
                        let vc = HostMenuVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }) { (error) in
            self.txtSms.resignFirstResponder()
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
   
    
    //MARK: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
