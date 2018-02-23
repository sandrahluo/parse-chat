//
//  LoginViewController.swift
//  parse-chat
//
//  Created by Sandra Luo on 2/22/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let alertController = UIAlertController(title: "Incomplete Fields", message: "Please enter a username and password", preferredStyle: .alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        if ((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!) {
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        }
        
    }
    
    // when signup button is pressed
    @IBAction func onSignup(_ sender: Any) {
        registerUser()
    }
    
    // when login button is pressed
    @IBAction func onLogin(_ sender: Any) {
        loginUser()
    }
    
    func registerUser() {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("User registered successfully!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func loginUser() {
        // ?? = nil coalescing operator
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed:\(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
