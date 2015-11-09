//
//  InitialViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/6/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var trebekTitleLabel: UILabel!
    @IBOutlet weak var trebekImageView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        trebekTitleLabel.alpha = 0
        trebekImageView.alpha = 0
        loginButton.alpha = 0
        registerButton.alpha = 0
        
        trebekImageView.center = CGPoint(x: trebekImageView.center.x, y: trebekImageView.center.y + 3)
        
        UIView.animateWithDuration(0.33) { () -> Void in
            self.trebekImageView.alpha = 1
            self.trebekImageView.center = CGPoint(x: self.trebekImageView.center.x, y: self.trebekImageView.center.y - 3)

            
        }
        
        UIView.animateWithDuration(0.16) { () -> Void in
            self.trebekTitleLabel.alpha = 1
            self.loginButton.alpha = 1
            self.registerButton.alpha = 1
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
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
