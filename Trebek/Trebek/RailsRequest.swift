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
private let _API_URL_REGISTRATION = "https://nameless-plains-2123.herokuapp.com/registrations"
private let _USERS_LOGIN = "/login"
private let _USERS_REGISTER = "/signup"
private let _USERS_DECK = "/deck"
private let _ID_CARDS = ":/id/cards"

private let NAME = "name"
private let USER = "user"
private let USERNAME = "username"
private let PASSWORD = "password"
private let EMAIL = "email"
private let ERRORS = "errors"


private let ACCESS_TOKEN = "access_token" // need to get

class RailsRequest: NSObject {
    
    class func session() -> RailsRequest {return _railsRequest }
    
    var currentName: String? {
        get { return _default.objectForKey(NAME) as? String }
        set { _default.setObject(newValue, forKey: NAME) }
            
    }
    
    var currentUsername: String? {
        get { return _default.objectForKey(USERNAME) as? String }
        set { _default.setObject(newValue, forKey: USERNAME) }
        
    }
    
    var currentPassword: String? {
        get { return _default.objectForKey(PASSWORD) as? String }
        set { _default.setObject(newValue, forKey: PASSWORD) }
        
    }
    
    var currentEmail: String? {
        get { return _default.objectForKey(EMAIL) as? String }
        set { _default.setObject(newValue, forKey: EMAIL) }
    }
    
    var token: String? {
        get { return _default.objectForKey(ACCESS_TOKEN) as? String }
        set { _default.setObject(newValue, forKey: ACCESS_TOKEN) }
        
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
                if let key = user[ACCESS_TOKEN] as? String {
                    self.token = key
                    print(self.token)
                    
                }
                
            }
            
            if let error = returnedInfo?[ERRORS] as? [String] {
                print(error)
                
            }
            
        }
        
    }
    
    func registerWithUsername(name: String, username:String, password:String, email:String) {
        var info = RequestInfo()
        info.endPoint = _USERS_REGISTER
        info.method = .POST
        info.parameters = [
            NAME : name,
            USERNAME : username,
            PASSWORD : password,
            EMAIL : email
        
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            if let user = returnedInfo?[USER] as? [String:AnyObject] {
                if let key = user[ACCESS_TOKEN] as? String {
                    self.token = key
                    print(self.token)
                    
                }
                
                if let name = user[NAME] as? String {
                    self.currentName = name
                }
                
                if let username = user[USERNAME] as? String {
                    self.currentUsername = username
                }
                
                if let password = user[PASSWORD] as? String {
                    self.currentPassword = password
                }
                
                
                if let email = user[EMAIL] as? String {
                    self.currentEmail = email
                }
                
                if let error = returnedInfo?[ERRORS] as? [String] {
                    print(error)
                    
                }
                
            }
            
        }
        
    }
    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo:AnyObject?) -> ()) {
        let fullURLString = base + info.endPoint
        
        guard let url = NSURL(string: fullURLString) else { return }
        let request = NSMutableURLRequest(URL: url)
        print("url: \(url)")
        
        request.HTTPMethod = info.method.rawValue
        
        if let token = token {
            request.setValue(token, forHTTPHeaderField: ACCESS_TOKEN)
            print(token)
            
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
                    print(returnedInfo)
                    
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
    var query: [String:AnyObject] = [:]
    
}