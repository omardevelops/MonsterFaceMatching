//
//  FacialExpression.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/29/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import Foundation

struct Expression {
    
    enum Eyes: Int {
        case Closed
        case Open
    }
    enum Mouth : Int {
        case Joy
        case Smile
        case SlightSmile
        case Neutral
        case Frown
        case Angry
    }
    
    var eyes : Eyes
    
    var mouth : Mouth
}
