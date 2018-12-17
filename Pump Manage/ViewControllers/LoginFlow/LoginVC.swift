//
//  Login.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 17/08/18.
//

import UIKit

class LoginVC: BaseViewController,UITextFieldDelegate{

    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwOtp: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblLogin:UILabel!
    @IBOutlet weak var lblConnecting:UILabel!
    @IBOutlet weak var lblAccount:UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnTwiiter: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var bottomVwBottom: NSLayoutConstraint!
    @IBOutlet weak var topVwLogin: NSLayoutConstraint!
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    // MARK: Button IBAction
    @IBAction func btnSignup(_ sender: Any) {
        let vc = RegistrationVC() 
          self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if(txtEmail.text?.isEmptyString())!{
            showToastMessage(pleaseEnterEmail)
        }else if(txtPass.text?.isEmptyString())!{
            showToastMessage(pleaseEnterPassword)
        }else{
            loginApi()
        }
    }
    
    @IBAction func btnBottomClicked(_ sender: Any) {
        if(bottomVwBottom.constant == 0){
            bottomVwBottom.constant = -110
            btnBottom.setImage(UIImage(named: "up"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }else{
            bottomVwBottom.constant = 0
            btnBottom.setImage(UIImage(named: "down"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func btnSmsClicked(_ sender: Any){
        self.SendOtp(type: smsType)
        let otpVC = OtpVC(nibName: "OtpVC", bundle: nil)
        otpVC.type = smsType
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    @IBAction func btnEmailClicked(_ sender: Any){
        self.SendOtp(type: emailType)
        let otpVC = OtpVC(nibName: "OtpVC", bundle: nil)
        otpVC.type = emailType
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    // MARK: TextField Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
       let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(LoginVC.dismissPicker))
       textField.inputAccessoryView = toolBar
        if(textField == txtPass){
            if(UIDevice().currentDevice() == iPhone5s5c5SE){
                topVwLogin.constant = -40
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtEmail){
            if(txtEmail.text?.isEmptyString())!{
                showToastMessage(pleaseEnterEmailPhone)
            }else{
             txtPass.becomeFirstResponder()
            }
        }else {
            if(txtPass.text?.isEmptyString())!{
                showToastMessage(pleaseEnterPassword)
            }else{
                if(UIDevice().currentDevice() == iPhone5s5c5SE){
                    topVwLogin.constant = 0
                }
                textField.resignFirstResponder()
            }
        }
        return true
    }
    
    
    //MARK: Custom function
    func design()
    {
        view.backgroundColor = AppColor.appColor
        vwTop.backgroundColor = AppColor.backgroundColor
        btnFacebook.backgroundColor = AppColor.backgroundColor
        btnTwiiter.backgroundColor = AppColor.backgroundColor
        btnGoogle.backgroundColor = AppColor.backgroundColor        
        btnLogin.appButton(title: login)
        lblTitle.setTitleLabel(title: welcometo)
        lblLogin.setSubTitleLabel(title: loginToContinue)
        lblConnecting.text = connectingWith
        lblAccount.text = dontHaveAccount
        btnSignUp.setTitle(signUp, for: .normal)
        let yourAttributes : [NSAttributedStringKey: Any] = [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        let attributeString = NSMutableAttributedString(string: (btnSignUp.titleLabel?.text)!,
                                                        attributes: yourAttributes)
        btnSignUp.setAttributedTitle(attributeString, for: .normal)
        txtEmail.applyPlacHolder(placeHolderText: "Email/Phone", color: AppColor.loginTextPlaceHolerColor)
        txtPass.applyPlacHolder(placeHolderText: "Password", color: AppColor.loginTextPlaceHolerColor)
        vwBottom.addShadow(location: .top)
        btnBottom.addShadow()
    }
    @objc func dismissPicker() {
        txtEmail.resignFirstResponder()
        txtPass.resignFirstResponder()
        topVwLogin.constant = 0
    }
    
    //MARK: Api Call
    func loginApi(){
        let userDict:NSMutableDictionary = NSMutableDictionary()
        userDict.setValue(txtEmail.text, forKey: "username")
        userDict.setValue(txtPass.text, forKey: "password")
        APIService.sharedInstance.makeCall(requestMethod: "POST", apiName: loginUrl, params: userDict, forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    if(error == "Not Verified"){
                        if(response != nil) {
                            let resDict = response as! NSDictionary
                            let customerModel:CustomerModel =  CustomerModel().initCustomerData(dicRes: resDict)
                            setUserDetails(user: customerModel)
                            appDelegate?.customerModel = customerModel
                        }
                        self.vwMain.isHidden = true
                        self.vwOtp.isHidden = false
                    }else{
                        showToastMessage(error!)
                    }
                }else{
                    if(response != nil) {
                        let resDict = response as! NSDictionary
                        appDelegate?.customerModel =  CustomerModel().initCustomerData(dicRes: resDict)
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: UserDefaultsKey.loggedInKey)
                        defaults.synchronize()
                        setUserDetails(user:  (appDelegate?.customerModel)!)
                        let vc = HostMenuVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
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
