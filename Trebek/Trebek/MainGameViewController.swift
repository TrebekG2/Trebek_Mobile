//
//  MainGameViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/4/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let WOO_HOO = "wooHoo"
private let SCORE = "Score: "

class MainGameViewController: UIViewController {
    //MARK: - Properties
    var score = 0
    
    //MARK: - @IBOutlet
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var questionLabelVerticalContraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonVerticalConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var buttonVerticalConstraints2: NSLayoutConstraint!
    
    //MARK: - @IBActions
    @IBAction func submitButtonPressed(sender: AnyObject) {
        score += 10
        scoreLabel.text = SCORE + String(score)
        
    }
    
    @IBAction func skipButtonPressed(sender: AnyObject) {
        if score > 0 {
            score -= 5
            scoreLabel.text = SCORE + String(score)
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate(answerTextField)

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

extension MainGameViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.layoutIfNeeded()
        UIView.animateWithDuration(0.66) { () -> Void in
            textField.resignFirstResponder()
            self.questionLabelVerticalContraint.constant = 0
            self.buttonVerticalConstraints.constant = 20
            self.buttonVerticalConstraints2.constant = 20
            
            self.view.layoutIfNeeded()

        }

        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        view.layoutIfNeeded()
        UIView.animateWithDuration(0.45) { () -> Void in
            self.questionLabelVerticalContraint.constant -= 200
            self.view.layoutIfNeeded()
            
        }

        UIView.animateWithDuration(0.46) { () -> Void in
            self.buttonVerticalConstraints.constant += 200
            self.buttonVerticalConstraints2.constant += 200

            self.view.layoutIfNeeded()
            
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.layoutIfNeeded()
         textField.resignFirstResponder()
        UIView.animateWithDuration(0.66) { () -> Void in
            self.questionLabelVerticalContraint.constant = 0
            self.buttonVerticalConstraints.constant = 20
            self.buttonVerticalConstraints2.constant = 20
            self.view.layoutIfNeeded()
        
        }

    }
    func setDelegate(textField: UITextField) {
        textField.delegate = self
        
    }
    
    
}
