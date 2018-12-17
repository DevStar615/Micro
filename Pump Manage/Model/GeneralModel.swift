//
//  GeneralModel.swift
//  Pump Manage
//
//  Created by mac on 30/08/18.
//

import UIKit

class GeneralModel: NSObject {
    var response : Any?
    var success : Int = 0
    var errMsg :String  = " "
    var customer : Any?
    
    func addResponseToModel(res: NSDictionary) -> GeneralModel{
        if(res.value(forKey: "token") != nil){
            let token:String = res.value(forKey: "token") as! String
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: UserDefaultsKey.authenticationKey)
            defaults.synchronize()
        }
        bindData(dic: res, str: "response", type: &self.response)
        bindData(dic: res, str: "success", type: &self.success)
        bindData(dic: res, str: "customer", type: &self.customer)
        bindData(dic: res, str: "error", type: &self.errMsg)
        return self
    }
}
