//
//  LoginViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/4/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let EMPTY_STRING = ""
class LoginViewController: UIViewController {
    //MARK: - Properties
    
    //MARK: - @IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - @IBActions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        guard let username = nameTextField.text where username != EMPTY_STRING else { return }
        guard let password = passwordTextField.text where password != EMPTY_STRING else { return }
        
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        guard let name = nameTextField.text where name != EMPTY_STRING else { return }
        
        guard let username = usernameTextField.text where name != EMPTY_STRING else { return }
        guard let password = passwordTextField.text where password != EMPTY_STRING else { return }
        
        guard let email = emailTextField.text where email != EMPTY_STRING else { return }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
