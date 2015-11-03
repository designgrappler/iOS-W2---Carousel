//
//  LoginViewController.swift
//  Week 2 - Carousel
//
//  Created by designgrappler on 11/1/15.
//  Copyright © 2015 designgrappler. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 600
        )
        scrollView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }

        func scrollViewDidScroll(scrollView: UIScrollView) {
            // If the scrollView has been scrolled down by 50px or more...
            if scrollView.contentOffset.y <= -50 {
            // Hide the keyboard
            view.endEditing(true)
            }
        }
    
        func keyboardWillShow(notification: NSNotification!) {
        
            // Move the button up above keyboard
            buttonParentView.transform = CGAffineTransformMakeTranslation(0, -120)
            // Calculate the maximum scrollview content Offset y
            let maxContentOffsetY = scrollView.contentSize.height - scrollView.frame.size.height
            // Scroll the scrollview up to the maximum contentOffset
            scrollView.contentOffset.y = maxContentOffsetY
            // Enable scrolling while keyboard is shown
            scrollView.scrollEnabled = true
        }
    
        func keyboardWillHide(notification: NSNotification!) {
            // Move the buttons back down to it's original position
            buttonParentView.transform = CGAffineTransformIdentity
            // Return the ScrollView to it's original position
            scrollView.contentOffset.y = 0
            // Disable scrolling when keyboard is hidden
            scrollView.scrollEnabled = false
        }
    

    @IBAction func signInBackButton(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func loginButton(sender: AnyObject) {
        self.activityIndicator.startAnimating()

        if emailField.text == "timbo@fb.com" && passwordField.text == "password"{
            delay(2, closure: { () -> () in
                self.activityIndicator.stopAnimating()
                self.loginButton.selected = false
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                })
            
        } else if emailField.text!.isEmpty {
            self.activityIndicator.stopAnimating()
            self.loginButton.selected = false
            let alertController = UIAlertController(title: "Email Required", message: "Enter your email address", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else if passwordField.text!.isEmpty || emailField.text!.isEmpty {
            self.activityIndicator.stopAnimating()
            self.loginButton.selected = false
            let alertController = UIAlertController(title: "Password Required", message: "Enter your password", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            delay(2, closure: { () -> () in
                self.activityIndicator.stopAnimating()
                self.loginButton.selected = false
                let alertController = UIAlertController(title: "Invalid Email or Password", message: "Please try again", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

