//
//  CityModel.swift
//  Pump Manage
//
//  Created by mac on 04/09/18.
//

import UIKit

class CityModel: NSObject {
    var id : Int = 0
    var name : String = " "
    
    func initWithCityData(res: NSArray) -> [CityModel]{
        var arrCity = [CityModel]()
        for response in res{
            let res = response as! NSDictionary
            let obj = CityModel()
            bindData(dic: res, str: "id", type: &obj.id)
            bindData(dic: res, str: "cityName", type: &obj.name)
            arrCity.append(obj)
        }
        return arrCity
    }
}
