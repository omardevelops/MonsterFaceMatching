//
//  ViewController.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/13/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    var timer = Timer()
    var endTimer = Timer()
    var startTimer = Timer()
    var seconds = 60 // Default is 60
    var score = 1 // Default is 0
    var isFirstTime = true // To check if views are randomized for the first time
    var isRandomizing = false // To fix a bug where the faces became equal more than once which added multiple scores
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var leaveGameButton: UIButton!
    
    @objc func updateTimer() {
        seconds -= 1
        if (seconds == 0) {
            timerLabel.text = "TIME UP!"
            timerLabel.textColor = UIColor.white
            timerLabel.backgroundColor = UIColor.systemBlue
            scoreLabel.text = "FinalScore: "+String(score)
            scoreLabel.textColor = UIColor.black
            scoreLabel.backgroundColor = UIColor.systemYellow
            firstFaceView.isUserInteractionEnabled = false
            secondFaceView.isUserInteractionEnabled = false
            leaveGameButton.setTitle("Next >", for: .normal)
            leaveGameButton.setTitleColor(UIColor.white, for: .normal)
            leaveGameButton.backgroundColor = UIColor.systemGreen
            timer.invalidate()
            
        } else {
            timerLabel.text = String(seconds) + "s left"
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        updateUI()
        secondUpdateUI()
        print(isFacesEquals())
        randomizeExpressions()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FinalViewController
        destinationVC.finalScore = score
    }
    
    @IBAction func pressExitGame(_ sender: UIButton) {
        timer.invalidate()
        let alert = UIAlertController(title: "Are you sure you want to exit?", message: "Your score will be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.performSegue(withIdentifier: "resultsPage", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }))
        self.present(alert, animated: true)
        
    }
    

    
    // Tapping the face controls the curvature of the mouth
    @IBAction func tappedFace(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            
            switch expression.mouth {
            case .Joy:
                expression.mouth = .Smile
            case .Smile:
                expression.mouth = .SlightSmile
            case .SlightSmile:
                expression.mouth = .Neutral
            case .Neutral:
                expression.mouth = .Frown
            case .Frown:
                expression.mouth = .Sad
            case .Sad:
                expression.mouth = .Joy
                
            }
            
        }
        
    }
    // Long Press controls the open/closed eyes
    @IBAction func longPressFace(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
                   print("begin")
                   
                   
                   switch expression.eyes {
                    case .Open:
                        expression.eyes = .Closed
                    case .Closed:
                        expression.eyes = .LeftOpenRightClosed
                    case .LeftOpenRightClosed:
                        expression.eyes = .LeftClosedRightOpen
                 
                   case .LeftClosedRightOpen:
                    expression.eyes = .Open
                   }
            
                
               }
        
    }
    
    // SWIPE UP RECOGNIZER
    @IBAction func swipeUpOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            expression.colorPattern = .Robot
        }
            
            
        }
    @IBAction func swipeRightOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            expression.colorPattern = .Ghost
            
        }
    }
    @IBAction func swipeDownOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            expression.colorPattern = .Pumpkin
        }
    }
    @IBAction func swipeLeftOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            expression.colorPattern = .Frog
        }
    }
    @IBAction func pinchToReset(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            expression.colorPattern = .Yellow

        }
    }
    @IBAction func secondTap(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            
            switch secondExpression.mouth {
            case .Joy:
                secondExpression.mouth = .Smile
            case .Smile:
                secondExpression.mouth = .SlightSmile
            case .SlightSmile:
                secondExpression.mouth = .Neutral
            case .Neutral:
                secondExpression.mouth = .Frown
            case .Frown:
                secondExpression.mouth = .Sad
            case .Sad:
                secondExpression.mouth = .Joy
                
            }
            
        }
    }
    @IBAction func secondHoldOnFace(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
               
               
               switch secondExpression.eyes {
                case .Open:
                    secondExpression.eyes = .Closed
                case .Closed:
                    secondExpression.eyes = .LeftOpenRightClosed
                case .LeftOpenRightClosed:
                    secondExpression.eyes = .LeftClosedRightOpen
             
               case .LeftClosedRightOpen:
                secondExpression.eyes = .Open
               }
        
            
           }
    }
    @IBAction func secondPinchFace(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            secondExpression.colorPattern = .Yellow

        }
    }
    @IBAction func SecondSwipeUpOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            secondExpression.colorPattern = .Robot
        }
            
            
        }
        
    @IBAction func SecondSwipeRightOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            secondExpression.colorPattern = .Ghost
        }
            
    }
    @IBAction func SecondSwipeDownOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            secondExpression.colorPattern = .Pumpkin
        }
            
        
    }
    @IBAction func secondSwipeLeftOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            secondExpression.colorPattern = .Frog
        }
            
    }
    @IBOutlet weak var firstFaceView: FaceView! {
        didSet {
            updateUI()
            if (!isRandomizing) {
            print(isFacesEquals())
            }
        }
    }
    var expression = Expression(eyes: .Open, mouth: .Smile, colorPattern: .Pumpkin) {
        didSet{
            updateUI() // to update the view every time the model changes
            if (!isRandomizing) {
            print(isFacesEquals())
            }
        }
    }
    @IBOutlet weak var secondFaceView: FaceView! {
        didSet {
            secondUpdateUI()
            if (!isRandomizing) {
            print(isFacesEquals())
            }
        }
    }
    var secondExpression = Expression(eyes: .Open, mouth: .Smile, colorPattern: .Ghost) {
        didSet{
            secondUpdateUI() // to update the view every time the model changes
            if (!isRandomizing) {
            print(isFacesEquals())
            }
        }
    }
    
   func secondUpdateUI() {
            switch secondExpression.eyes {
            case .Closed :
                secondFaceView.leftEyeOpen = false
                secondFaceView.rightEyeOpen = false
            case .Open :
                secondFaceView.leftEyeOpen = true
                secondFaceView.rightEyeOpen = true
            case .LeftOpenRightClosed :
                secondFaceView.leftEyeOpen = true
                secondFaceView.rightEyeOpen = false
            case .LeftClosedRightOpen :
                secondFaceView.leftEyeOpen = false
                secondFaceView.rightEyeOpen = true
        }
            switch secondExpression.mouth {
            case .Neutral :
                secondFaceView.mouthCurvature = 0
                secondFaceView.isMouthFilled = false
            case .Smile :
                secondFaceView.mouthCurvature = 0.4
                secondFaceView.isMouthFilled = false
            case .Joy :
                secondFaceView.mouthCurvature = 0.6
                secondFaceView.isMouthFilled = true
            case .SlightSmile :
                secondFaceView.mouthCurvature = 0.2
                secondFaceView.isMouthFilled = false
            case .Frown:
                secondFaceView.mouthCurvature = -0.2
                secondFaceView.isMouthFilled = false
            case .Sad :
                secondFaceView.mouthCurvature = -0.4
                secondFaceView.isMouthFilled = false
            }
            
            switch secondExpression.colorPattern {
            case .Yellow:
                secondFaceView.skullColor = UIColor(red: 253/255, green: 213/255, blue: 60/255, alpha: 1.0) // Yellow
                secondFaceView.eyeColor = UIColor.white
                secondFaceView.eyeBallColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0) // Black Coffee Color
                secondFaceView.mouthColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0) // Black Coffee Color
            case .Robot:
                secondFaceView.skullColor = UIColor(red: 14/255, green: 121/255, blue: 178/255, alpha: 1.0) // Alien Green
                secondFaceView.eyeColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 0.5) // Black Coffee Color
                secondFaceView.eyeBallColor = UIColor(red: 35/255, green: 240/255, blue: 199/255, alpha: 1.0) // White Eyeball
                secondFaceView.mouthColor = UIColor(red: 35/255, green: 240/255, blue: 199/255, alpha: 1.0) // White Eyeball

            case .Pumpkin:
                secondFaceView.skullColor = UIColor(red: 254/255, green: 127/255, blue: 45/255, alpha: 1.0) // Alien Green
                secondFaceView.eyeColor = UIColor(red: 81/255, green: 33/255, blue: 0/255, alpha: 1.0) // Black Coffee Color
                secondFaceView.eyeBallColor = secondFaceView.eyeColor
                secondFaceView.mouthColor = secondFaceView.eyeBallColor
            case .Frog:
                secondFaceView.skullColor = UIColor(red: 7/255, green: 75/255, blue: 26/255, alpha: 1.0) // Yellow
                secondFaceView.eyeColor = UIColor.white
                secondFaceView.eyeBallColor = UIColor.black
                secondFaceView.mouthColor = UIColor.systemRed
            case .Ghost: //pink-red color
                secondFaceView.skullColor = UIColor(red: 251/255, green: 254/255, blue: 249/255, alpha: 1) // Yellow
                secondFaceView.eyeColor = UIColor.white
                secondFaceView.eyeBallColor = UIColor(red: 54/255, green: 17/255, blue: 52/255, alpha: 1.0) // Black Coffee Color
                secondFaceView.mouthColor = secondFaceView.eyeBallColor
            }
            
            
            
            
        
    }
    
    func updateUI() {
        print("I am in updateUI function")
        switch expression.eyes {
        case .Closed :
            firstFaceView.leftEyeOpen = false
            firstFaceView.rightEyeOpen = false
        case .Open :
            firstFaceView.leftEyeOpen = true
            firstFaceView.rightEyeOpen = true
        case .LeftOpenRightClosed :
            firstFaceView.leftEyeOpen = true
            firstFaceView.rightEyeOpen = false
        case .LeftClosedRightOpen :
            firstFaceView.leftEyeOpen = false
            firstFaceView.rightEyeOpen = true
    }
        switch expression.mouth {
        case .Neutral :
            firstFaceView.mouthCurvature = 0
            firstFaceView.isMouthFilled = false
        case .Smile :
            firstFaceView.mouthCurvature = 0.4
            firstFaceView.isMouthFilled = false
        case .Joy :
            firstFaceView.mouthCurvature = 0.6
            firstFaceView.isMouthFilled = true
        case .SlightSmile :
            firstFaceView.mouthCurvature = 0.2
            firstFaceView.isMouthFilled = false
        case .Frown:
            firstFaceView.mouthCurvature = -0.2
            firstFaceView.isMouthFilled = false
        case .Sad :
            firstFaceView.mouthCurvature = -0.4
            firstFaceView.isMouthFilled = false
        }
        
        switch expression.colorPattern {
        case .Yellow:
            firstFaceView.skullColor = UIColor(red: 253/255, green: 213/255, blue: 60/255, alpha: 1.0) // Yellow
            firstFaceView.eyeColor = UIColor.white
            firstFaceView.eyeBallColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0) // Black Coffee Color
            firstFaceView.mouthColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0) // Black Coffee Color
        case .Robot:
            firstFaceView.skullColor = UIColor(red: 14/255, green: 121/255, blue: 178/255, alpha: 1.0) // Alien Green
            firstFaceView.eyeColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 0.5) // Black Coffee Color
            firstFaceView.eyeBallColor = UIColor(red: 35/255, green: 240/255, blue: 199/255, alpha: 1.0) // White Eyeball
            firstFaceView.mouthColor = firstFaceView.eyeBallColor

        case .Pumpkin:
            firstFaceView.skullColor = UIColor(red: 254/255, green: 127/255, blue: 45/255, alpha: 1.0) // Alien Green
            firstFaceView.eyeColor = UIColor(red: 81/255, green: 33/255, blue: 0/255, alpha: 1.0) // Black Coffee Color
            firstFaceView.eyeBallColor = firstFaceView.eyeColor
            firstFaceView.mouthColor = firstFaceView.eyeBallColor
        case .Frog:
            firstFaceView.skullColor = UIColor(red: 7/255, green: 75/255, blue: 26/255, alpha: 1.0) // Yellow
            firstFaceView.eyeColor = UIColor.white
            firstFaceView.eyeBallColor = UIColor.black
            firstFaceView.mouthColor = UIColor.systemRed
        case .Ghost: //pink-red color
            firstFaceView.skullColor = UIColor(red: 251/255, green: 254/255, blue: 249/255, alpha: 1) // Yellow
            firstFaceView.eyeColor = UIColor.white
            firstFaceView.eyeBallColor = UIColor(red: 54/255, green: 17/255, blue: 52/255, alpha: 1.0) // Black Coffee Color
            firstFaceView.mouthColor = UIColor(red: 54/255, green: 17/255, blue: 52/255, alpha: 1.0) // Black Coffee Color
        }
             
}
    func isFacesEquals() -> Bool{
        let isEyesEquals = expression.eyes == secondExpression.eyes
        let isMouthsEquals = expression.mouth == secondExpression.mouth
        let isColorEquals = expression.colorPattern == secondExpression.colorPattern
        
        if(isEyesEquals && isMouthsEquals && isColorEquals) {
            timer.invalidate() // Pauses countdown
            endTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(equalTimer), userInfo: nil, repeats: false)
            
            scoreLabel.text = "MATCH"
            scoreLabel.textColor = UIColor.systemGreen
            firstFaceView.isUserInteractionEnabled = false
            secondFaceView.isUserInteractionEnabled = false
            return true
        } else {
        return false
        }
            
    }
    @objc func equalTimer() {
        scoreLabel.textColor = UIColor.systemYellow
        score += 1
        scoreLabel.text = "Score: "+String(score)
        randomizeExpressions()
        firstFaceView.isUserInteractionEnabled = true
        secondFaceView.isUserInteractionEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    func randomizeExpressions() {
        isRandomizing = true
        expression.eyes = Expression.Eyes(rawValue: Int.random(in: 0...3))!
        secondExpression.eyes = Expression.Eyes(rawValue: Int.random(in: 0...3))!
        expression.mouth = Expression.Mouth(rawValue: Int.random(in: 0...5))!
        secondExpression.mouth = Expression.Mouth(rawValue: Int.random(in: 0...5))!
        expression.colorPattern = Expression.ColorPattern(rawValue: Int.random(in: 0...4))!
        secondExpression.colorPattern = Expression.ColorPattern(rawValue: Int.random(in: 0...4))!
        isRandomizing = false
        
        
    }
}
    
    
    


