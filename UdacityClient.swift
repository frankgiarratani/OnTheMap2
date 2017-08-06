//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Frank Giarratani on 2017/08/06.
//  Copyright © 2017 Frank Giarratani. All rights reserved.
//

import Foundation

typealias RequestCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: NSError?) -> Void



// MARK: - UdacityClient: NSObject

class UdacityClient : NSObject {
    
    static let url = URL(string: "https://www.udacity.com/api/session")
    static let session = URLSession.shared
    
    static func signInWithUsername(_ username: String, password: String, completion: RequestCompletionHandler?) {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: String.Encoding.utf8)
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
    }


}
