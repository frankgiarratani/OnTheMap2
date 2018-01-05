//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Frank Giarratani on 2017/12/16.
//  Copyright © 2017 Frank Giarratani. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient : NSObject {

    // MARK: Properties
    var session = URLSession.shared
    var appDelegate: AppDelegate!
    var keyboardOnScreen = false

    // authentication state
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: Int? = nil
    
    // MARK: Initializers
    override init() {
        super.init()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: Completion Handler typealias
    typealias CompletionHandler = (_ result: AnyObject?, _ error: NSError?) -> Void
        
    func authenticateUser(username: String, password: String, completionHandler: CompletionHandler) {
        
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("authenticateUser running with following username and password")
        print("USERNAME: " + username)
        print("PASSWORD: " + password)
        print("- - - - - - - - - - - - - - - - - - - - - -")

        taskForPOST(username: username, password: password) {
            (result, error) -> Void in
            if let error = error {
                print("###Error: \(error.localizedDescription)")
            } else {
                print("###Request Token: \(result!)")
            }
        }
        
    }
    
    func taskForPOST(username: String, password: String, completionHandler: @escaping CompletionHandler) {

        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("taskForPOST started")
        print("- - - - - - - - - - - - - - - - - - - - - -")
        
        
        //build the post request http body
        var postRequest = "{\"udacity\": {\"username\": \""
        postRequest.append(username)
        postRequest.append("\", \"password\": \"")
        postRequest.append(password)
        postRequest.append("\"}}")
        print("POST" + postRequest)
        
        //build the post request
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postRequest.data(using: String.Encoding.utf8)
        print(request.httpBody!)
        
        
        //run the task
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error { // Handle error…
                completionHandler(nil, error as NSError)
            } else if let data = data {
                self.parseJSON(data: data, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print ("taskForPOST fully executed")
        print("- - - - - - - - - - - - - - - - - - - - - -")
    }
    
    func parseJSON(data: Data, completionHandler: CompletionHandler){
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("parsedUdacityJSON function started")
        print("- - - - - - - - - - - - - - - - - - - - - -")

        let range = Range(5..<data.count)
        let newData = data.subdata(in: range) /* subset response data! */
        
        //Parse the JSON dictionary into two dictionaries (account and session)
        let parsedUdacityJSON = try! JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! NSDictionary
        
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("parsedUdacityJSON")
        print("- - - - - - - - - - - - - - - - - - - - - -")
        //print(parsedUdacityJSON)
        print("- - - - - - - - - - - - - - - - - - - - - -")
        
        
        //Create accountDictionary
        guard let accountDictionary = parsedUdacityJSON["account"] as? NSDictionary else {
            print("Cannot find key 'account' in \(parsedUdacityJSON)")
            return
        }
        
        //Extract accountKey
        if let accountKey = accountDictionary["key"] {
            self.appDelegate.accountKey = accountKey as? String
            print("accountKey:" + self.appDelegate.accountKey!)
            completionHandler(accountKey as AnyObject, nil)
        }
        
        //Create sessionDictionary
        guard let sessionDictionary = parsedUdacityJSON["session"] as? NSDictionary else {
            print("Cannot find key 'account' in \(parsedUdacityJSON)")
            return
        }
        
        //Extract sessionID
        if let sessionID = sessionDictionary["id"] {
            self.appDelegate.sessionID  = sessionID as? String
            print("sessionID:" + self.appDelegate.sessionID!)
        }
        
        self.getUdacityUserData()
    }
    
    private func getUdacityUserData() {
        var userinfoURL = "https://www.udacity.com/api/users/"
        userinfoURL.append(self.appDelegate.accountKey!)
        let request = NSMutableURLRequest(url: URL(string: userinfoURL)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
            
            //Parse the JSON dictionary into a dictionary
            let parsedUdacityUserDataJSON = try! JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! NSDictionary
            
            
            print("- - - - - - - - - - - - - - - - - - - - - -")
            print("parsedUdacityUserDataJSON")
            //print(parsedUdacityUserDataJSON)
            print("- - - - - - - - - - - - - - - - - - - - - -")
            self.deleteUdacitySession()
            
            
        }
        
        task.resume()
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("getUdacityUserData fully executed")
        print("- - - - - - - - - - - - - - - - - - - - - -")

    }
    
    private func deleteUdacitySession(){
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        print("- - - - - - - - - - - - - - - - - - - - - -")
        print("deleteUdacitySession fully executed")
        print("- - - - - - - - - - - - - - - - - - - - - -")

    }
    
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }

}
