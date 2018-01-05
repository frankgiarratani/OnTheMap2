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
    @IBOutlet weak var usernameTextfield : UITextField!
    @IBOutlet weak var passwordTextfield : UITextField!
    @IBOutlet weak var debugTextLabel : UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // get the app delegate
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }

    
    // MARK: Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if usernameTextfield.text!.isEmpty || passwordTextfield.text!.isEmpty {
            //debugTextLabel.text = "Username or Password Empty."
            UserAlert.popUpAlert(view: self, message: "Username or password empty")
        }
        else {
            debugTextLabel.text = " 🔐 Authenticating..."
            UdacityClient.sharedInstance().authenticateUser(username: usernameTextfield.text!, password: passwordTextfield.text!, completionHandlerForAuthenticateUser: { (success, errorString) in
                
                if let errorString = errorString {
                    performUIUpdatesOnMain {
                        self.debugTextLabel.text = errorString
                        return
                    }
                }
                
                if success {
                    performUIUpdatesOnMain {
                        self.debugTextLabel.text = "SUCCESS!!"
                        return
                    }
                }
        })
        
        //print("Login Button Pressed")
        
        }
    }
    
    @IBAction func noAccountButtonPressed(_ sender: Any) {
        print("No Account Button Pressed")
        debugTextLabel.text = "Sign me up for an account."
        //https://www.udacity.com/account/auth#!/signup
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
