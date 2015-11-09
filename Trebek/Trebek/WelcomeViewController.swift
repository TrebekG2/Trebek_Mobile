//
//  WelcomeViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/6/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var user = String()
    var decks = []
    var categories = []
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeString = "Welcome \(user)"
        welcomeLabel.text = welcomeString
    }
    
    override func viewDidAppear(animated: Bool) {
        let welcomeString = "Welcome \(user)"
        welcomeLabel.text = welcomeString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
