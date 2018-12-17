//
//  CountryModel.swift
//  Pump Manage
//
//  Created by mac on 04/09/18.
//

import UIKit

class CountryModel: NSObject {
    var id : Int = 0
    var name : String = " "
    
    func initWithCountryData(res: NSArray) -> [CountryModel]{
        var arrCountry = [CountryModel]()
        for response in res{
            let res = response as! NSDictionary
            let obj = CountryModel()
            bindData(dic: res, str: "id", type: &obj.id)
            bindData(dic: res, str: "countryName", type: &obj.name)
            arrCountry.append(obj)
        }
        return arrCountry
    }

}
