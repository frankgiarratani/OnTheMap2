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
    
    // shared session
    var session = URLSession.shared
    
    // authentication state
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: Int? = nil
    
    // MARK: Initializers
    override init() {
        super.init()
    }
        
    func authenticateUser(username: String, password: String) -> Void {
        print("------------------------------")
        print("------------------------------")
        print("------------------------------")
        print("USERNAME: " + username)
        print("PASSWORD: " + password)
        print("------------------------------")
        print("------------------------------")
        print("------------------------------")

    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }

}
