//
//  RailsRequest.swift
//  RR
//
//  Created by Joe E. on 11/5/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let _railsRequest = RailsRequest()
private let _default = NSUserDefaults.standardUserDefaults()
private let _API_URL = "https://nameless-plains-2123.herokuapp.com"
private let _USERS_LOGIN = "/users/login"
private let USERNAME = "username"
private let PASSWORD = "password"

private let USER = "user"
private let ACCESS_KEY = "access key"
private let TOKEN = "token"

class RailsRequest: NSObject {
    class func session() -> RailsRequest { return _railsRequest }
    
    var token: String? {
        get { return _default.objectForKey(TOKEN) as? String }
        set { _default.setObject(newValue, forKey: TOKEN) }
        
    }
    
    private let base = _API_URL
    
    func loginWithUsername(username: String, andPassword password: String) {
        var info = RequestInfo()
        info.endPoint = _USERS_LOGIN
        info.method = .POST
        info.parameters = [
            USERNAME : username,
            PASSWORD : password
        
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            if let user = returnedInfo?[USER] as? [String:AnyObject] {
                if let key = user[ACCESS_KEY] as? String {
                    self.token = key
                }
                
            }
            if let _ = returnedInfo?["errors"] as? [String] {
                
                
            }
            
        }
        
    }
    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo:AnyObject?) -> ()) {
        
        let fullURLString = base + info.endPoint
        
        guard let url = NSURL(string: fullURLString) else { return }
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        if let token = token {
            request.setValue(token, forKey: "")
            
        }
        
        if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
            if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                let postData =  jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.HTTPBody = postData
                
            }

        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                    completion(returnedInfo: returnedInfo)
                    
                }
                
            } else {
                
            }
            
        }
        
        task.resume()
    }
    
}

struct RequestInfo {
    enum MethodType:String {
        case POST, GET, DELETE
        
    }
    
    var endPoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
}