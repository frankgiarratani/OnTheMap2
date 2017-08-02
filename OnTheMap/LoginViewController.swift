//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Frank Giarratani on 2017/08/02.
//  Copyright © 2017 Frank Giarratani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        print("Login Button Pressed")
    }
    
    
    @IBAction func noAccountButtonPressed(_ sender: Any) {
        print("No Account Button Pressed")
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        print("Forgot Password Button Pressed")
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
