//
//  TutorialViewController.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/31/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapOnGhost(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
                    mouthCheckLabel.textColor = UIColor.systemGreen
                   print("tap")
               }
    }
    @IBAction func longPressGhost(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            
            eyesCheckLabel.textColor = UIColor.systemGreen
        }
    }
    @IBAction func swipeUpGhost(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            monsterCheckLabel.textColor = UIColor.systemTeal
        }
    }
    
    @IBAction func swipeRightGhost(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            monsterCheckLabel.textColor = UIColor.systemIndigo
        }
    }
    
    @IBAction func swipeDownGhost(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            monsterCheckLabel.textColor = UIColor.systemOrange
        }
    }
    
    @IBAction func swipeLeftGhost(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            monsterCheckLabel.textColor = UIColor.systemGreen
        }
    }
    
    @IBAction func pinchGhost(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .ended {
            monsterCheckLabel.textColor = UIColor.systemYellow
        }
    }
    @IBOutlet weak var eyesCheckLabel: UILabel!
    
    @IBOutlet weak var mouthCheckLabel: UILabel!
    
    @IBOutlet weak var monsterCheckLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
