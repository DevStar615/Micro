//
//  APIService.swift
//  Pump Manage
//
//  Created by mac on 30/08/18.
//

import UIKit
import AFNetworking

class APIService: UIView {
    static let sharedInstance: APIService = {
        let instance = APIService()
        return instance
    }()
    
    //Generate Url
    func generateGetUrl(apiName: String) -> String {
        let  urlString = "\(baseUrl)\(apiName)" as NSString
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedUrl!
    }
    
    //Generate Url With QueryString
    func generateGetUrlParam(apiName: String, params: NSDictionary) -> String {
        var queryString = "";
        var urlString:NSString = NSString()
        for key in params{
            queryString = "\(queryString)/\(key.value)"
        }
        if(!queryString.isEmpty){
            queryString.remove(at: queryString.startIndex)
            urlString = "\(baseUrl)\(apiName)/\(queryString)" as NSString
        }else{
            urlString = "\(baseUrl)\(apiName)" as NSString
        }
        print("\(baseUrl)\(apiName)?\(queryString)")
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedUrl!
    }
    
    //Call Api of Get Post Delete Put
     func makeCall(requestMethod : String, apiName : String,params: NSMutableDictionary, isTokenRequired: Bool = true, forSuccessionBlock successBlock: @escaping (_ newResponse: Any?,_ error: String?) -> Void, andFailureBlock failureBlock: @escaping (_ error: Error) -> Void) {
        
        let manager = AFHTTPSessionManager()
        
        let serializerRequest = AFJSONRequestSerializer()
        serializerRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        serializerRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer = serializerRequest
    
        let serializerResponse = AFJSONResponseSerializer()
        serializerResponse.readingOptions = JSONSerialization.ReadingOptions.allowFragments
        serializerResponse.acceptableContentTypes = ["text/html","application/json"]
        manager.responseSerializer = serializerResponse
        
        var apiUrlParam = self.generateGetUrlParam(apiName: apiName, params: params)
        apiUrlParam = apiUrlParam.replacingOccurrences(of: " ", with: "%20")
        
        if(requestMethod == "GET"){
            manager.get(apiUrlParam, parameters: nil, progress: { (progress) in
                print("In process")
            }, success: { (task, response) in
                if let result = response as? NSDictionary {
                    let generalModel = GeneralModel().addResponseToModel(res: result)
                    if generalModel.success == 1 {
                        successBlock(generalModel.response, nil)
                    } else if generalModel.success == 0 {
                        successBlock(nil, generalModel.errMsg)
                    }
                }
            }) { (task, error) in
                failureBlock(error)
            }
        }else if(requestMethod == "POST"){
            var apiUrl = self.generateGetUrl(apiName: apiName)
            apiUrl = apiUrl.replacingOccurrences(of: " ", with: "%20")
            manager.post(apiUrl, parameters: params, progress: { (progress) in
                print("Post In Progress")
            }, success: { (task, response) in
                if let result = response as? NSDictionary {
                    let generalModel = GeneralModel().addResponseToModel(res: result)
                    if generalModel.success == 1 {
                        if(generalModel.customer != nil){
                            let msg = generalModel.response as! String
                            showToastMessage(msg)
                            successBlock(generalModel.customer, nil)
                        }else{
                            successBlock(generalModel.response, nil)
                        }
                    } else if generalModel.success == 0 {
                        if(generalModel.customer != nil){
                            showToastMessage(generalModel.errMsg)
                            successBlock(generalModel.customer, "Not Verified")
                        }else{
                            successBlock(nil, generalModel.errMsg)
                        }
                    }
                }
            }) { (task, error) in
                failureBlock(error)
            }
        }
    }
}
