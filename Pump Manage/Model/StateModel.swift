//
//  StateModel.swift
//  Pump Manage
//
//  Created by mac on 04/09/18.
//

import UIKit

class StateModel: NSObject {
    var id : Int = 0
    var name : String = " "
    
    func initWithStateData(res: NSArray) -> [StateModel]{
        var arrState = [StateModel]()
        for response in res{
            let res = response as! NSDictionary
            let obj = StateModel()
            bindData(dic: res, str: "id", type: &obj.id)
            bindData(dic: res, str: "stateName", type: &obj.name)
            arrState.append(obj)
        }
        return arrState
    }
}
