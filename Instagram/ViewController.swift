//
//  ViewController.swift
//  Instagram
//
//  Created by Mac on 28/04/15.
//  Copyright (c) 2015 CZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
 {
    
    var signupActive = true
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var alreadyRegistered: UILabel!

    
    @IBOutlet weak var signup: UIButton!
    
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username and password"
            
        }
        
        
        if error != "" {
            
            displayAlert("Error In Form", error: error)
            
        } else {
            
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, signupError: NSError?) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()//user can use the app again
                    
                    if signupError == nil  {
                        
                        println("signed up")
                        
                    self.performSegueWithIdentifier("jumpToUserTable", sender: "self")
                        
                        
                    } else {
                        if let errorString = signupError!.userInfo?["error"] as? NSString {
                            
                            error = errorString as String
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Sign Up", error: error)
                        
                    }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                    (user: PFUser?, signupError: NSError?) -> Void in
                    
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil {
                        
                    self.performSegueWithIdentifier("jumpToUserTable", sender: "self")
                        
                        println("logged in")
                        
                    } else {
                        
                        if let errorString = signupError!.userInfo?["error"] as? NSString {
                            
                            error = errorString as String
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Log In", error: error)
                        
                        
                    }
                }
                
                
            }
            
            
        }

        
    }
    
    @IBOutlet weak var login: UIButton!
    
    @IBAction func logIn(sender: AnyObject) {
        
        
        if signupActive == true {
            
            signupActive = false
            
            detailsLabel.text = "Use the form below to log in"
            
            signup.setTitle("Log In", forState: UIControlState.Normal)
            
            alreadyRegistered.text = "Not Registered?"
            
            login.setTitle("Sign Up", forState: UIControlState.Normal)
            
            
        } else {
            
            signupActive = true
            
            detailsLabel.text = "Use the form below to sign up"
            
            login.setTitle("Sign Up", forState: UIControlState.Normal)
            
            alreadyRegistered.text = "Already Registered?"
            
            signup.setTitle("Log In", forState: UIControlState.Normal)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func viewDidAppear(animated: Bool) {
    
    if PFUser.currentUser() != nil {
    
    self.performSegueWithIdentifier("login", sender: self)
    
    
    }
    
    
    }
    */


}