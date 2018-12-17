//
//  CreditModel.swift
//  Pump Manage
//
//  Created by mac on 30/08/18.
//

import UIKit

class CreditModel: NSObject {
    
    var key:String = " "
    var value:String = " "
    
    func initCreditData(arrRes: NSArray) -> Dictionary<String,String> {
       var dictCredit = Dictionary<String, String>()
        for response in arrRes{
            let obj = response as! NSDictionary
            let objList = CreditModel()
            bindData(dic: obj, str: "key", type: &objList.key)
            bindData(dic: obj, str: "value", type: &objList.value)
            dictCredit[objList.key] = objList.value
        }
        return dictCredit
    }
}
