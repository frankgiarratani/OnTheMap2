//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Frank Giarratani on 2017/08/02.
//  Copyright © 2017 Frank Giarratani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    // MARK: Properties
    
    var appDelegate: AppDelegate!
    var keyboardOnScreen = false
    
    // MARK : Outlets
    @IBOutlet weak var usernameEntered : UITextField!
    @IBOutlet weak var passwordEntered : UITextField!
    @IBOutlet weak var debugTextLabel : UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // get the app delegate
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    
    
    // MARK: Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //userDidTapView(self)
        
        if usernameEntered.text!.isEmpty || passwordEntered.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {

            debugTextLabel.text = "Username and Password are good to go."
        }
        
        print("Login Button Pressed")
        
        
        //print(usernameEntered.text!)
        //print(passwordEntered.text!)
        
        var postRequest = "{\"udacity\": {\"username\": \""
        postRequest.append(usernameEntered.text!)
        postRequest.append("\", \"password\": \"")
        postRequest.append(passwordEntered.text!)
        postRequest.append("\"}}")
        
        print("POST" + postRequest)
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        
        request.httpBody = postRequest.data(using: String.Encoding.utf8)
        print(request.httpBody!)
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
    
    
    @IBAction func noAccountButtonPressed(_ sender: Any) {
        print("No Account Button Pressed")
        debugTextLabel.text = "Sign me up for an account."
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        print("Forgot Password Button Pressed")
        debugTextLabel.text = "Take me to the password reset page."
    }
    
    
    

    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
