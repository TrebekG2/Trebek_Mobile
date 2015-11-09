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
    var ids = []
    var categories = []
    var decksLoaded = true
    
    @IBAction func chooseDeckPressed(sender: AnyObject) {

        
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeString = "Welcome \(user)"
        welcomeLabel.text = welcomeString
        print("decks: \(decks)")
        
//        RailsRequest.session().getDecksAndIDs({ (success) -> () in
//            if let titles = RailsRequest.session().deck {
//                self.decks = titles
//                
//            }
//            
//        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destination = segue.destinationViewController as?
            DeckTableViewController {
                destination.decks = decks
        }
        
    }

}
