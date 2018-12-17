//
//  Constants.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 18/08/18.
//

import UIKit

struct AppColor {
    static let borderColor = UIColor.white
    static let loginTextPlaceHolerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let loginButtonColor = #colorLiteral(red: 1, green: 0.09411764706, blue: 0.2666666667, alpha: 1)
    static let homePageButton = #colorLiteral(red: 0.8459396958, green: 0.2834488153, blue: 0, alpha: 1)
    static let backgroundColor = #colorLiteral(red: 0, green: 0.2039215686, blue: 0.3921568627, alpha: 1)
    static let appColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
}

struct AppFont {
    static let balubhaiFont = "BalooBhai-Regular"
    static let montSerratFont = "Montserrat-Medium"
    static let varelaRoundFont = "VarelaRound-Regular"
    static let robotoMedium = "Roboto-Medium"
    static let robotoLight = "Roboto-Light"
    static let robotoRegular = "Roboto-Regular"
    static let robotoBold = "Roboto-Bold"
    static let robotoThin = "Roboto-Thin"
}

struct Screen{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct UserDefaultsKey{
    static let loggedInKey = "loggedIn"
    static let customerKey = "customer"
    static let authenticationKey = "authentication"
}

let appDelegate = UIApplication.shared.delegate as? AppDelegate
