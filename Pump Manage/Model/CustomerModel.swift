//
//  CustomerModel.swift
//  Pump Manage
//
//  Created by mac on 01/09/18.
//

import UIKit

class CustomerModel: NSObject, NSCoding {
    
    var id:String = " "
    var firstName:String = " "
    var lastName:String = " "
    var address:String = " "
    var email:String = " "
    var phoneNumber:String = " "
    var dateOfBirth:String = " "
    
    override init() {
        
    }
    
    
    init(id:String,firstName:String,lastName:String,address:String,email:String,phoneNumber:String,dateOfBirth:String) {
        self.id  = id
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.email = email
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
    }
    
    func initCustomerData(dicRes: NSDictionary) -> CustomerModel {
        bindData(dic: dicRes, str: "id", type: &self.id)
        bindData(dic: dicRes, str: "firstName", type: &self.firstName)
        bindData(dic: dicRes, str: "lastName", type: &self.lastName)
        bindData(dic: dicRes, str: "address", type: &self.address)
        bindData(dic: dicRes, str: "email", type: &self.email)
        bindData(dic: dicRes, str: "phoneNumber", type: &self.phoneNumber)
        bindData(dic: dicRes, str: "dateOfBirth", type: &self.dateOfBirth)
        return self
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        let lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        let dateOfBirth = aDecoder.decodeObject(forKey: "dateOfBirth") as! String
        self.init(
            id: id,
            firstName: firstName,
            lastName: lastName,
            address: address,
            email: email,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(dateOfBirth, forKey: "dateOfBirth")
    }
}
