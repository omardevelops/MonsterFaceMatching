//
//  ViewController.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/13/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        
    }

    // Tapping the face controls the curvature of the mouth
    @IBAction func tappedFace(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            print("ouch")
            
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
            print(expression.mouth)
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
            
                print(expression.eyes)
               }
        
    }
    
    // SWIPE UP RECOGNIZER
    @IBAction func swipeUpOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("Swiped upwards")
            expression.colorPattern = .Robot
        }
            print(expression.colorPattern)
            
        }
    @IBAction func swipeRightOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("Swiped right")
            expression.colorPattern = .Ghost
            
        }
    }
    @IBAction func swipeDownOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("Swiped down")
            expression.colorPattern = .Pumpkin
        }
    }
    @IBAction func swipeLeftOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("Swiped left")
            expression.colorPattern = .Frog
        }
    }
    @IBAction func pinchToReset(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            print("I got pinched!")
            expression.colorPattern = .Yellow
            expression.eyes = .Open
            expression.mouth = .Smile

        }
    }
    @IBOutlet weak var firstFaceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    var expression = Expression(eyes: .Open, mouth: .Smile, colorPattern: .Ghost) {
        didSet{
            updateUI() // to update the view every time the model changes
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
            firstFaceView.mouthColor = firstFaceView.eyeBallColor
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
            firstFaceView.mouthColor = firstFaceView.eyeBallColor
        }
        
        
        
        
    
}
}
    
    
    


