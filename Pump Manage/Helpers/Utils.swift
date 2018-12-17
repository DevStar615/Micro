//
//  Utils.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 18/08/18.
//

import UIKit

enum VerticalLocation: String {
    case bottom
    case top
}

//MARK:- get Value by key from the dictionary
func bindData<T>(dic: NSDictionary,str: String, type: inout T){
    if let val: T = dic[str] as? T{
        type = val
    }else{
        if let val = dic[str]{
            let strVal = String(describing: val)
            if let val: T = strVal as? T{
                type = val
            }
        }
    }
}

//MARK:- set Customer details in Userdefaults after login
func setUserDetails(user: CustomerModel) {
    let defaults = UserDefaults.standard
    let userData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
    defaults.set(userData, forKey: UserDefaultsKey.customerKey)
    defaults.synchronize()
}

//MARK:- get Customer details from user defaults
func getUserDetails() -> CustomerModel? {
    let defaults = UserDefaults.standard
    if defaults.value(forKey: UserDefaultsKey.customerKey) != nil{
        let nsData = defaults.value(forKey: UserDefaultsKey.customerKey) as! Data
        let objUser = NSKeyedUnarchiver.unarchiveObject(with: nsData) as! CustomerModel
        return objUser
    }
    return nil
}

//MARK: Extensions
extension String{
    func localize() -> String{
        let path = Bundle.main.path(forResource: appDelegate?.currentLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    func isEmptyString() -> Bool{
        let trimmedString = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
}

extension UIButton {
    func homePageButton(title: String, rect: CGRect) {
        self.layer.cornerRadius = rect.size.height / 2
        self.backgroundColor = AppColor.homePageButton
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.titleLabel?.font = UIFont(name: AppFont.varelaRoundFont, size: 17)
    }
    func mapDetailsButton(title: String, rect: CGRect) {
        self.layer.cornerRadius = rect.size.height / 2
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.titleLabel?.font = UIFont(name: AppFont.varelaRoundFont, size: 17)
    }
    func appButton(title:String){
        self.layer.cornerRadius = 5
        self.backgroundColor = AppColor.backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.titleLabel?.font = UIFont(name: AppFont.robotoMedium, size: 13)
    }
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity =  0.5
        self.layer.shadowRadius = 5.0
    }
}

extension UILabel{
    func setTitleLabel(title: String){
        self.font = UIFont(name: AppFont.robotoBold, size: 25)
        self.text = title
        self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    func setSubTitleLabel(title:String){
        self.font = UIFont(name: AppFont.robotoMedium, size: 17)
        self.text = title
        self.textColor = AppColor.backgroundColor
    }
    func setMiniTitleLabel(title:String){
        self.font = UIFont(name: AppFont.robotoRegular, size: 12)
        self.text = title
        self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

extension UIView{
    func likeDislikeView(rect: CGRect) {
        self.layer.cornerRadius = rect.size.height / 2
    }
    func asImage()->UIImage{
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    func addShadow(location: VerticalLocation, color: UIColor = .gray, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 2), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -2), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .gray, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension UITextField{
    func applyPlacHolder(placeHolderText:String,color:UIColor){
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedStringKey.foregroundColor: color])
        self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.font = UIFont(name: AppFont.robotoBold, size: 14)
        self.backgroundColor = AppColor.backgroundColor
    }
}

extension Date {
    func stringFromDate(date:Date,format:String) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func add(value: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: value, to: self)
    }
}

extension UIDevice{
    func currentDevice() -> String{
        var str = "unknown"
        if self.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
               str = iPhone5s5c5SE
            case 1334:
                str =  iPhone676S8
            case 1920, 2208:
                str = iPhone676s8plus
            case 2436:
                str = iPhonex
            default:
                print("unknown")
            }
        }
        return str
    }
}

extension UIToolbar {    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}



