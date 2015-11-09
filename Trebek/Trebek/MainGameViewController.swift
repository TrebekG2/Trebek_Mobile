//
//  MainGameViewController.swift
//  Trebek
//
//  Created by Joe E. on 11/4/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import QuartzCore

private let WOO_HOO = "wooHoo"
private let SCORE = "Score: "

private let QUESTION = "question"
private let question1 = "To be or not to be..."
private let question2 = "How many states are in the United States?"
private let question3 = "Who is the best group?"

private let ANSWER = "answer"
private let answer1 = "that is the question"
private let answer2 = "50"
private let answer3 = "everyone"

private let GAME_OVER = "Game Over"
private let TRANSFORM = "transform"

private var currentQuestion = 1
private var questionCount = 0

class MainGameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let anim = CAKeyframeAnimation(keyPath: TRANSFORM)

    var score = 0
    var originalPoint = CGPoint()
    
    var questions:[String] = [question1, question2, question3]
    var answers:[String] = [answer1, answer2, answer3]
    
    //MARK: - @IBOutlet
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var questionLabelVerticalContraint: NSLayoutConstraint!

    @IBOutlet weak var buttonVerticalConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var buttonVerticalConstraints2: NSLayoutConstraint!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    //MARK: - @IBActions
    @IBAction func submitButtonPressed(sender: AnyObject) {
        if let answer = answerTextField.text {
            if let correctAnswer = answerTextField.placeholder {
                if answer == correctAnswer {
                    
                    UIView.animateWithDuration(0.25) { () -> Void in
                        self.scoreLabel.alpha = 0
                        self.questionLabel.alpha = 0
                        self.score += 10
                        
                        self.scoreLabel.text = SCORE + String(self.score)
                        
                        if currentQuestion == 4 {
                            self.questionLabel.text = GAME_OVER
                            
                        } else if currentQuestion < 4 {
                            self.questionLabel.text = self.questions[currentQuestion]
                            self.answerTextField.text = ""
                            
                        }
                        
                        self.answerTextField.placeholder = self.answers[currentQuestion]
                        
                    }
                    
                    UIView.animateWithDuration(0.66) { () -> Void in
                        self.scoreLabel.alpha = 1
                        self.view.backgroundColor = UIColor.greenColor()
                     
                        self.view.alpha = 1
                        
                    }
                    
                    UIView.animateWithDuration(1) { () -> Void in
                        self.view.backgroundColor = UIColor.whiteColor()
                        self.questionLabel.alpha = 1
                        
                    }
                    
                } else if answer != correctAnswer {
                    
                    anim.values = [NSValue(CATransform3D:CATransform3DMakeTranslation(-3, 0, 0)), NSValue( CATransform3D: CATransform3DMakeTranslation(3, 0, 0))]
                    
                    anim.autoreverses = true
                    anim.repeatCount = 4
                    
                    anim.duration = 0.06
                    
                    scoreLabel.layer.addAnimation(anim, forKey: nil)
                    answerTextField.layer.addAnimation(anim, forKey: nil)
                    questionLabel.layer.addAnimation(anim, forKey: nil)
                    submitButton.layer.addAnimation(anim, forKey: nil)
                    skipButton.layer.addAnimation(anim, forKey: nil)
                    
                    UIView.animateWithDuration(0.66, animations: { () -> Void in
                        self.view.backgroundColor = UIColor.redColor()
                        
                        
                        
                    })
                    
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.view.backgroundColor = UIColor.whiteColor()
                        self.questionLabel.center = CGPoint(x: self.questionLabel.center.x, y: self.questionLabel.center.y)
                        
                    })
                    
                    score -= 1
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func skipButtonPressed(sender: AnyObject) {
        if score > 0 {
            score -= 5
            scoreLabel.text = SCORE + String(score)
            
        }
    
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if recognizer.state == .Began {
            UIView.animateWithDuration(0.66, animations: { () -> Void in
                self.view.layer.borderColor = UIColor.whiteColor().CGColor
                self.view.backgroundColor = UIColor.grayColor()
                self.visualEffectView.alpha = 1
                
            })
            
        }
        
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
            recognizer.setTranslation(CGPointZero, inView: view)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.layer.masksToBounds = true 
        questionLabel.layer.cornerRadius = 20
        questionLabel.layer.borderColor = UIColor.grayColor().CGColor
        questionLabel.layer.borderWidth = 1
        visualEffectView.alpha = 0

        questionCount = questions.count
        
        setDelegate(answerTextField)
        
        //TO-FIX: 
        
        questionLabel.text = questions[0]
        answerTextField.placeholder = answers[0]

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidDisappear(animated: Bool) {
        questionLabel.text = questions[0]
        answerTextField.placeholder = answers[0]
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
