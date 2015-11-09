//
//  GameplayNavigationController.swift
//  Trebek
//
//  Created by Joe E. on 11/6/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class GameplayNavigationController: UINavigationController {
    
    var user = String()
    var decks = []
    var categories = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let welcomeVC = self.viewControllers.first as? WelcomeViewController {
            welcomeVC.user = user
            
        }
     
    }

}
