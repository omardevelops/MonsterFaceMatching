//
//  FinalViewController.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/31/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit
import Foundation

class FinalViewController: UIViewController {
    var finalScore : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Final View")
        // Do any additional setup after loading the view.
        print(finalScore)
        finalScoreNumber.text = String(finalScore)
        
        if(finalScore < 7) {
            finalScoreNumber.textColor = UIColor.systemOrange
            motivationLabel.text = "You can do better.\n I believe in you!"
            motivationLabel.textColor = UIColor.systemOrange
        } else if (finalScore >= 15) {
            finalScoreNumber.textColor = UIColor(red: 6/255, green: 214/255, blue: 160/255, alpha: 1)
            motivationLabel.text = "SPECTACULAR!"
            motivationLabel.textColor = UIColor(red: 6/255, green: 214/255, blue: 160/255, alpha: 1)
        } else {
            finalScoreNumber.textColor = UIColor(red: 244/255, green: 213/255, blue: 141/255, alpha: 1)
            motivationLabel.textColor = UIColor(red: 244/255, green: 213/255, blue: 141/255, alpha: 1)
        }
    }
    @IBOutlet weak var motivationLabel: UILabel!
    
    @IBOutlet weak var finalScoreTitle: UILabel!
    
    @IBOutlet weak var finalScoreNumber: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
