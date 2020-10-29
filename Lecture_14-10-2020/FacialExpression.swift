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
        case LeftOpenRightClosed
        case LeftClosedRightOpen
        case Open
        case Closed
    }
    enum Mouth : Int {
        case Joy
        case Smile
        case SlightSmile
        case Neutral
        case Frown
        case Sad
    }
    enum ColorPattern: Int {
        case Yellow
        case Pumpkin
        case Robot
        case Frog
        case Ghost
        
    }
    
    var eyes : Eyes
    
    var mouth : Mouth
    
    var colorPattern : ColorPattern
}
