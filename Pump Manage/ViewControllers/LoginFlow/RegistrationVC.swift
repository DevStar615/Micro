//
//  RegistrationVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 17/08/18.
//

import UIKit
import CTKFlagPhoneNumber

let smsType = "phoneNumber"
let emailType = "email"

class RegistrationVC: BaseViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var vwOtp: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var vwStep2: UIView!
    @IBOutlet weak var vwStep3: UIView!
    @IBOutlet var vwPicker: UIView!
    @IBOutlet var picker:UIPickerView!
    
    @IBOutlet weak var vwScroll: UIScrollView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhone: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblStreetNo: UILabel!
    @IBOutlet weak var lblPostalCode: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOtpText: UILabel!
    @IBOutlet weak var lblStep: UILabel!
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnConfirm1: UIButton!
    @IBOutlet weak var btnConfirm2: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnSMS: UIButton!
    
    var activeField: UITextField?
    var arrCountry = [CountryModel]()
    var arrState = [StateModel]()
    var arrCity = [CityModel]()
    var countryId:Int?
    var stateId:Int?
    var cityId:Int?
    var countryRow:Int?
    var stateRow:Int?
    var cityRow:Int?
    var otpType:String?
    var isCountryChanged:Bool = false
    
    //MARK:-  View LifeCycle
    override func viewDidLoad() {
         super.viewDidLoad()
        design()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:-  Keyboard Notification Methods
    @objc func keyboardWillShow(notification:NSNotification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height - 20, 0.0)
        self.vwScroll.contentInset = contentInsets
        self.vwScroll.scrollIndicatorInsets = contentInsets
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if (!aRect.contains(activeField!.frame.origin))
        {
            self.vwScroll.scrollRectToVisible((activeField?.frame)!, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -20, 0.0)
        self.vwScroll.contentInset = contentInsets
        self.vwScroll.scrollIndicatorInsets = contentInsets
    }
    
    //MARK:-  Textfield Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(RegistrationVC.dismissPicker))
        if(textField == txtDob){
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
            datePickerView.maximumDate = Date()
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
            textField.inputAccessoryView = toolBar
        }else if(textField == txtPostalCode ){
            textField.inputAccessoryView = toolBar
        }else if(textField == txtPhone){
            textField.inputAccessoryView = toolBar
            txtPhone.keyboardType = .numberPad
        }else if(textField == txtCountry || textField == txtState || textField == txtCity){
            textField.inputAccessoryView = toolBar
            if(textField == txtCountry  ){
                if(countryRow != nil){
                    self.picker.selectRow(countryRow!, inComponent: 0, animated: true)
                }
                if(arrCountry.count > 0){
                    let countryModel = arrCountry[countryRow!]
                    txtCountry.text = countryModel.name
                    getState()
                }
            }else if(textField == txtState){
                if(isCountryChanged){
                    getState()
                    isCountryChanged = false
                }
                if(stateRow != nil){
                    self.picker.selectRow(stateRow!, inComponent: 0, animated: true)
                }
            }else{
                getCity()
                if(cityRow != nil){
                     self.picker.selectRow(cityRow!, inComponent: 0, animated: true)
                }
            }
            textField.inputView = vwPicker
            picker.reloadAllComponents()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtName){
            checkForValidation(textField: textField, nxtTextField: txtLastName, msg: pleaseEnterFirstName)
        }else if(textField == txtLastName){
            checkForValidation(textField: textField, nxtTextField: txtDob, msg: pleaseEnterLastName)
        }else if(textField == txtEmail){
            checkForValidation(textField: textField, nxtTextField: UITextField(), msg: pleaseEnterEmail)
        }else if(textField == txtStreet){
            checkForValidation(textField: textField, nxtTextField: txtPostalCode, msg: pleaseEnterStreet)
        }else if(textField == txtPassword){
            checkForValidation(textField: textField, nxtTextField: txtConfirmPassword, msg: pleaseEnterPassword)
        }else if(textField == txtConfirmPassword){
            checkForValidation(textField: textField, nxtTextField: UITextField(), msg: pleaseEnterConfirmPassword)
        }
        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    //MARK:- PickerView Delegate and Datasource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(activeField == txtCountry){
            return arrCountry.count > 0 ? arrCountry.count : 0
        }else if(activeField == txtState){
            return arrState.count > 0 ? arrState.count : 0
        }else if(activeField == txtCity){
            return arrCity.count > 0 ? arrCity.count : 0
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(activeField == txtCountry){
            let country = arrCountry[row]
            return country.name
        }else if(activeField == txtState){
            let state = arrState[row]
            return state.name
        }else if(activeField == txtCity){
            let city = arrCity[row]
            return city.name
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(activeField == txtCountry){
            let country = arrCountry[row]
            txtCountry.text = country.name
            countryId = country.id
            if(countryRow != row){
                txtState.text = ""
                txtCity.text = ""
                arrState = [StateModel]()
                arrCity = [CityModel]()
                isCountryChanged = true
            }
            countryRow = row
        }else if(activeField == txtState){
            let state = arrState[row]
            txtState.text = state.name
            stateId = state.id
            if(stateRow != row){
                txtCity.text = ""
                arrCity = [CityModel]()
            }
            stateRow = row
        }else if(activeField == txtCity){
            let city = arrCity[row]
            txtCity.text = city.name
            cityId = city.id
            cityRow = row
        }
        self.picker.selectRow(row, inComponent: 0, animated: true)
    }
    
    //MARK:-  IBAction Methods
    @IBAction func btnConfirmClicked(_ sender: Any){
        if(!vwStep1.isHidden){
            if(checkConfirmStep1Validation() == true){
                getCountries()
                vwStep1.isHidden = true
                vwStep2.isHidden = false
                btnBack.isHidden = false
                lblStep.text = "Step 2"
                txtStreet.becomeFirstResponder()
            }
        }else if(!vwStep2.isHidden){
            if(checkConfirmStep2Validation() == true){
                vwStep2.isHidden = true
                vwStep3.isHidden = false
                btnBack.isHidden = false
                lblStep.text = "Step 3"
                txtPassword.becomeFirstResponder()
            }
        }
        else if(!vwStep3.isHidden){
            if(checkConfirmStep3Validation() == true){
                self.vwMain.isHidden = true
                self.vwOtp.isHidden = false
                //registerUser()
            }
        }
    }
    @IBAction func btnBackStepClicked(_ sender: Any){
        if(!vwStep2.isHidden){
            vwStep2.isHidden = true
            vwStep1.isHidden = false
            btnBack.isHidden = true
            lblStep.text = "Step 1"
            txtName.becomeFirstResponder()
        }
        else if(!vwStep3.isHidden){
            vwStep3.isHidden = true
            vwStep2.isHidden = false
            btnBack.isHidden = false
            lblStep.text = "Step 2"
            txtStreet.becomeFirstResponder()
        }
    }
    @IBAction func btnBackOtpClicked(_ sender: Any){
        self.vwMain.isHidden = false
        self.vwOtp.isHidden = true
    }
    @IBAction func btnSmsClicked(_ sender: Any){
        otpType = smsType
        self.registerUser()
    }
    @IBAction func btnEmailClicked(_ sender: Any){
        otpType = emailType
        self.registerUser()
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
     }
      
    //MARK:-  Custom function
    func design() {
        vwTop.backgroundColor = AppColor.backgroundColor
        view.backgroundColor = AppColor.appColor
        lblTitle.setTitleLabel(title: welcometo)
        lblStep.textColor = AppColor.backgroundColor
        
        txtName.applyPlacHolder(placeHolderText: "First Name", color: AppColor.loginTextPlaceHolerColor)
        txtLastName.applyPlacHolder(placeHolderText: "Last Name", color: AppColor.loginTextPlaceHolerColor)
        txtStreet.applyPlacHolder(placeHolderText: "Street", color: AppColor.loginTextPlaceHolerColor)
        txtPostalCode.applyPlacHolder(placeHolderText: "Postal code", color: AppColor.loginTextPlaceHolerColor)
        txtCity.applyPlacHolder(placeHolderText: "Select City", color: AppColor.loginTextPlaceHolerColor)
        txtState.applyPlacHolder(placeHolderText: "Select State", color: AppColor.loginTextPlaceHolerColor)
        txtCountry.applyPlacHolder(placeHolderText: "Select Country", color: AppColor.loginTextPlaceHolerColor)
        txtPhone.applyPlacHolder(placeHolderText: "1234567890", color: AppColor.loginTextPlaceHolerColor)
        txtDob.applyPlacHolder(placeHolderText: "dd mmm yyyy", color: AppColor.loginTextPlaceHolerColor)
        txtEmail.applyPlacHolder(placeHolderText: "email", color: AppColor.loginTextPlaceHolerColor)
        txtPassword.applyPlacHolder(placeHolderText: password, color: AppColor.loginTextPlaceHolerColor)
        txtConfirmPassword.applyPlacHolder(placeHolderText: confirmPassword, color: AppColor.loginTextPlaceHolerColor)
        
        txtPhone.parentViewController = self
        txtPhone.hasPhoneNumberExample = false
        txtPhone.flagButton.isUserInteractionEnabled = true
        txtPhone.textAlignment = .left
        txtPhone.setFlag(for: "MX")
        
        lblName.setSubTitleLabel(title: firstName)
        lblLastName.setSubTitleLabel(title: lastName)
        lblStreetNo.setSubTitleLabel(title: streetNo)
        lblPostalCode.setSubTitleLabel(title: postalCode)
        lblCity.setSubTitleLabel(title: city)
        lblState.setSubTitleLabel(title: state)
        lblCountry.setSubTitleLabel(title: country)
        lblDob.setSubTitleLabel(title: dateOfBirth)
        lblPhone.setSubTitleLabel(title: phoneNumber)
        lblEmail.setSubTitleLabel(title: emailAddress)
        lblPassword.setSubTitleLabel(title: password)
        lblConfirmPassword.setSubTitleLabel(title: confirmPassword)
        lblOtpText.setSubTitleLabel(title: chooseOtpMethod)      

        btnConfirm.appButton(title: nextStr)
        btnConfirm1.appButton(title: nextStr)
        btnConfirm2.appButton(title: confirm)
        btnSMS.appButton(title: smsTxt)
        btnEmail.appButton(title: emailTxt)
        txtName.becomeFirstResponder()
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        txtDob.text = dateFormatter.string(from: sender.date)
    }
    @objc func dismissPicker() {
        if(activeField == txtDob){
            checkForValidation(textField: txtDob, nxtTextField: txtPhone, msg: pleaseEnterDob)
        }else if(activeField == txtPhone){
            checkForValidation(textField: txtPhone, nxtTextField: txtEmail, msg: pleaseEnterPhone)
        }else if(activeField == txtPostalCode){
           checkForValidation(textField: txtPostalCode, nxtTextField: txtCountry, msg: pleaseEnterPostal)
        }else if(activeField == txtCountry){
            getState()
            checkForValidation(textField: txtCountry, nxtTextField: txtState, msg: pleaseEnterCountry)
        }else if(activeField == txtState){
            getCity()
            checkForValidation(textField: txtState, nxtTextField: txtCity, msg: pleaseEnterState)
        }else if(activeField == txtCity){
            checkForValidation(textField: txtCity, nxtTextField: UITextField(), msg: pleaseEnterCity)
        }
    }

    func checkForValidation(textField:UITextField,nxtTextField:UITextField,msg:String){
        if(textField.text?.isEmptyString())!{
            showToastMessage(msg)
        }else if(textField == txtConfirmPassword){
            if(txtPassword.text != txtConfirmPassword.text){
                showToastMessage(passwordMatchError)
            }else{
                textField.resignFirstResponder()
                btnConfirm.isEnabled = true
                btnConfirm.alpha = 1.0
                btnConfirm.setTitle(confirm, for: .normal)
            }
        }else if(textField == txtEmail ){
            _ = checkConfirmStep1Validation()
        }else if(textField == txtCity){
            _ = checkConfirmStep2Validation()
        }else{
            nxtTextField.becomeFirstResponder()
        }
    }
    func checkConfirmStep1Validation() -> Bool{
        if((txtName.text?.isEmptyString())!){
            showToastMessage(pleaseEnterFirstName)
            return false
        }else if(txtLastName.text?.isEmptyString())!{
            showToastMessage(pleaseEnterLastName)
            return false
        }else if(txtDob.text?.isEmptyString())!{
            showToastMessage(pleaseEnterDob)
            return false
        }else if(txtPhone.text?.isEmptyString())!{
            showToastMessage(pleaseEnterPhone)
            return false
        }else if(txtEmail.text?.isEmptyString())!{
            showToastMessage(pleaseEnterEmail)
            return false
        }else if(!isValidEmail(testStr: txtEmail.text!)){
            showToastMessage(pleaseEnterEmail)
            return false
        }else{
            txtEmail.resignFirstResponder()
            return true
        }
    }
    func checkConfirmStep2Validation() -> Bool{
        if(txtStreet.text?.isEmptyString())!{
            showToastMessage(pleaseEnterStreet)
            return false
        }else if(txtPostalCode.text?.isEmptyString())!{
            showToastMessage(pleaseEnterPostal)
            return false
        }else if(txtCountry.text?.isEmptyString())!{
            showToastMessage(pleaseEnterCountry)
            return false
        }else if(txtState.text?.isEmptyString())!{
            showToastMessage(pleaseEnterState)
            return false
        }else if(txtCity.text?.isEmptyString())!{
            showToastMessage(pleaseEnterCity)
            return false
        }else{
            txtCity.resignFirstResponder()
            return true
        }
    }
    func checkConfirmStep3Validation() -> Bool{
        if(txtPassword.text?.isEmptyString())!{
            showToastMessage(pleaseEnterPassword)
            return false
        }else if(txtConfirmPassword.text?.isEmptyString())!{
            showToastMessage(pleaseEnterConfirmPassword)
            return false
        }else if(txtPassword.text != txtConfirmPassword.text){
            showToastMessage(passwordMatchError)
            return false
        }else{
            txtConfirmPassword.resignFirstResponder()
            btnConfirm.setTitle(confirm, for: .normal)
            return true
        }
    }
    //MARK:-  Api Call
    func registerUser(){
        let userDict:NSMutableDictionary = NSMutableDictionary()
        userDict.setValue(txtName.text, forKey: "firstName")
        userDict.setValue(txtLastName.text, forKey: "lastName")
        userDict.setValue(txtStreet.text, forKey: "streetNo")
        userDict.setValue(cityId, forKey: "cityId")
        userDict.setValue(stateId, forKey: "stateId")
        userDict.setValue(countryId, forKey: "countryId")
        userDict.setValue(txtPostalCode.text, forKey: "postalCode")
        userDict.setValue(txtDob.text, forKey: "dateOfBirth")
        userDict.setValue(txtPhone.getCountryPhoneCode(), forKey: "countryCode")
        userDict.setValue(txtPhone.getRawPhoneNumber(), forKey: "phoneNumber")
        userDict.setValue(txtEmail.text, forKey: "email")
        userDict.setValue(txtPassword.text, forKey: "password")                        
        userDict.setValue(otpType, forKey: "type")
        
        APIService.sharedInstance.makeCall(requestMethod: "POST", apiName: customerRegistration, params: userDict, forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                }else{
                    if(response != nil) {
                        let resDict = response as! NSDictionary
                        let customerModel =  CustomerModel().initCustomerData(dicRes: resDict)
                        appDelegate?.customerModel = customerModel
                        setUserDetails(user: customerModel)
                        let otpVc = OtpVC(nibName: "OtpVC", bundle: nil)
                        otpVc.type = self.otpType
                        self.navigationController?.pushViewController(otpVc, animated: true)
                    }
                }
            }
        }) { (error) in
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
    func getCountries(){
        APIService.sharedInstance.makeCall(requestMethod: "GET", apiName: countryUrl, params: NSMutableDictionary(), forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                }else{
                    if(response != nil) {
                        let resArr = response as! NSArray
                        self.arrCountry =  CountryModel().initWithCountryData(res: resArr)
                        if(self.arrCountry.count > 0){
                            let country = self.arrCountry[0]
                            self.countryId = country.id
                            self.countryRow = 0
                        }
                    }
                }
            }
        }) { (error) in
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
    func getState(){
        let dict = NSMutableDictionary()
        dict.setValue(countryId, forKey: "Id")
        APIService.sharedInstance.makeCall(requestMethod: "GET", apiName: stateUrl, params:dict , forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                }else{
                    if(response != nil) {
                        let resArr = response as! NSArray
                        self.arrState =  StateModel().initWithStateData(res: resArr)
                        self.picker.reloadAllComponents()
                        if(self.arrState.count > 0){
                            let state = self.arrState[0]
                            self.txtState.text = state.name
                            self.stateId = state.id
                            self.stateRow = 0
                        }
                    }
                }
            }
        }) { (error) in
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
    func getCity(){
        let dict = NSMutableDictionary()
        dict.setValue(stateId, forKey: "Id")
        APIService.sharedInstance.makeCall(requestMethod: "GET", apiName: cityUrl, params:dict , forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                }else{
                    if(response != nil) {
                        let resArr = response as! NSArray
                        self.arrCity =  CityModel().initWithCityData(res: resArr)
                        self.picker.reloadAllComponents()
                        if(self.arrCity.count > 0){
                            let city = self.arrCity[0]
                            self.txtCity.text = city.name
                            self.cityId = city.id
                            self.cityRow = 0
                        }
                        print(self.arrCity)
                    }
                }
            }
        }) { (error) in
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }

    //MARK:-  Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}












 
