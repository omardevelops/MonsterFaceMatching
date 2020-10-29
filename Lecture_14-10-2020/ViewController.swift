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
            print(expression.mouth)
            
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
                expression.mouth = .Angry
            case .Angry:
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
            
                print(expression.eyes)
               }
        
    }
    
    
    @IBAction func swipeUpOnFace(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            print("swiped")
            print(expression.colorPattern)
            
            switch expression.colorPattern {
            case .Alien:
                expression.colorPattern = .YellowEmoji
            case .YellowEmoji:
                expression.colorPattern = .Alien
        }
            
            
        }
    }
    @IBOutlet weak var firstFaceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    var expression = Expression(eyes: .Open, mouth: .Smile, colorPattern: .Alien) {
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
        case .Neutral : firstFaceView.mouthCurvature = 0
        case .Smile : firstFaceView.mouthCurvature = 0.5
        case .Joy : firstFaceView.mouthCurvature = 0.7
        case .SlightSmile : firstFaceView.mouthCurvature = 0.2
        case .Frown: firstFaceView.mouthCurvature = -0.2
        case .Angry : firstFaceView.mouthCurvature = -0.4
        }
        
        switch expression.colorPattern {
        case .YellowEmoji:
            firstFaceView.skullColor = UIColor(red: 253/255, green: 213/255, blue: 60/255, alpha: 1.0)
            firstFaceView.eyeColor = UIColor.white
            firstFaceView.eyeBallColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0)
        case .Alien:
            firstFaceView.skullColor = UIColor(red: 3/255, green: 167/255, blue: 157/255, alpha: 1.0)
            firstFaceView.eyeColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0)
            firstFaceView.eyeBallColor = UIColor.white
        }
        
        
    
}
    
    
    
}

