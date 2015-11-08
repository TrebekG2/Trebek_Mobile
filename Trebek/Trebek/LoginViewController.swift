//
//  LoginViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/4/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let EMPTY_STRING = ""
private let REGISTER_FAILED = "Register Failed"
private let LOGIN_FAILED = "Login Failed"
private let WELCOMEVC = "WelcomeVC"
private let STORYBORD_NAME = "Gameplay"
private let NAVIGATION_CONTROLLER = "GameplayNavigationController"

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    let usernameRequest = RailsRequest.session()
    
    //MARK: - @IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var bottomTextFieldConstraint: NSLayoutConstraint!
    
    //MARK: - @IBActions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        guard let username = usernameTextField.text where username != EMPTY_STRING else {
            return alertError(LOGIN_FAILED, reason: "Login is Empty.")}
        guard let password = passwordTextField.text where password != EMPTY_STRING else {
            return alertError(LOGIN_FAILED, reason: "Password is empty.")}
        
        RailsRequest.session().loginWithUsername(username, andPassword: password)
        
        if let vc = UIStoryboard(name: STORYBORD_NAME, bundle: nil).instantiateViewControllerWithIdentifier(NAVIGATION_CONTROLLER) as? GameplayNavigationController {
            vc.user = username
            if let firstVC = vc.viewControllers.first as? WelcomeViewController {
                firstVC.user = username
            }
            
            presentViewController(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        guard let name = nameTextField.text where name != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Name is empty.") }
        guard let username = usernameTextField.text where username != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Username is empty.")}
        guard let password = passwordTextField.text where password != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Password is empty.")}
        guard let email = emailTextField.text where email != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Email is empty.")}
        
        RailsRequest.session().registerWithUsername(name, username: username, password: password, email: email)
        
        if let vc = UIStoryboard(name: STORYBORD_NAME, bundle: nil).instantiateInitialViewController() as? GameplayNavigationController {
            vc.user = username
            if let firstVC = vc.viewControllers.first as? WelcomeViewController {
                firstVC.user = username
            }
            
            presentViewController(vc, animated: true, completion: nil)
            
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(animated: Bool) {
        nameTextField?.delegate = self
        usernameTextField?.delegate = self
        passwordTextField?.delegate = self
        emailTextField?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func alertError(title: String, reason:String) {
        
        let alertVC = UIAlertController(title: title, message: reason, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: { (action) -> Void in
            alertVC.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    


}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
//        view.layoutIfNeeded()
        self.bottomTextFieldConstraint.constant = 200
        UIView.animateWithDuration(0.50, animations: { () -> Void in
            self.view.layoutIfNeeded()
            
        })
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        
        UIView.animateWithDuration(0.50) { () -> Void in
            if self.bottomTextFieldConstraint.identifier == "Login" {
                self.bottomTextFieldConstraint.constant = 160
                self.view.layoutIfNeeded()
                
            } else {
                self.bottomTextFieldConstraint.constant = 80
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        
        UIView.animateWithDuration(0.50) { () -> Void in
            if self.bottomTextFieldConstraint.identifier == "Login" {
                self.bottomTextFieldConstraint.constant = 160
                self.view.layoutIfNeeded()
            } else {
                self.bottomTextFieldConstraint.constant = 60
                self.view.layoutIfNeeded()
                
            }
            
        }
        
        return true
    }
    
}