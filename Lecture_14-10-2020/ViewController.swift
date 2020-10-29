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
                   print(expression.eyes)
                   
                   switch expression.eyes {
                   case .Open:
                       expression.eyes = .Closed
                   case .Closed:
                       expression.eyes = .Open
                   }
               }
        
    }
    @IBOutlet weak var firstFaceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    var expression = Expression(eyes: .Open, mouth: .Joy) {
        didSet{
            updateUI() // to update the view every time the model changes
        }
    }
    
    func updateUI() {
        print("I am in updateUI function")
        switch expression.eyes {
        case .Closed : firstFaceView.eyesOpen = false
        case .Open : firstFaceView.eyesOpen = true
    }
        switch expression.mouth {
        case .Neutral : firstFaceView.mouthCurvature = 0
        case .Smile : firstFaceView.mouthCurvature = 0.5
        case .Joy : firstFaceView.mouthCurvature = 0.7
        case .SlightSmile : firstFaceView.mouthCurvature = 0.2
        case .Frown: firstFaceView.mouthCurvature = -0.2
        case .Angry : firstFaceView.mouthCurvature = -0.4
        }
        
        
    
}
    
    
    
}

