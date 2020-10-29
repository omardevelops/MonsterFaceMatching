//
//  FaceView.swift
//  Lecture_14-10-2020
//
//  Created by Omar Ahmed on 10/13/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var eyeBallColor: UIColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0)
    var skullColor: UIColor = UIColor(red: 253/255, green: 213/255, blue: 60/255, alpha: 1.0)
    var eyeColor: UIColor = UIColor.white
    var mouthColor: UIColor = UIColor(red: 58/255, green: 46/255, blue: 57/255, alpha: 1.0)
    
    
    private enum Eye {
        case Left
        case Right
    }
    
    
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var scale: CGFloat = 0.90 {
        didSet {
            setNeedsDisplay()
        }
    }
    var mouthCurvature: Double = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    var leftEyeOpen: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    var rightEyeOpen: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth: CGFloat = 9
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
        arcCenter: midPoint,
        radius: radius,
        startAngle: 0.0,
        endAngle: CGFloat(2*(Double.pi)),
        clockwise: false
        )
        path.lineWidth = 1
        return path
    }
    
   private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath
    {
        eyeColor.set()
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        if leftEyeOpen && eye == .Left {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
        } else if rightEyeOpen && eye == .Right {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
        }
        else {
            eyeBallColor.set()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    private func pathForEyeball(eye: Eye) -> UIBezierPath
    {
        eyeBallColor.set()
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeballRadius = eyeRadius / Ratios.EyeRadiusToEyeballRadius
        let eyeCenter = getEyeCenter(eye: eye)
        if leftEyeOpen && eye == .Left {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeballRadius)
        } else if rightEyeOpen && eye == .Right {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeballRadius)
        }
        else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset

        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        skullColor.set()
        let path = pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius)
        path.stroke()
        path.fill()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForEye(eye: .Left).fill()
        pathForEye(eye: .Right).fill()
        pathForEyeball(eye: .Left).fill()
        pathForEyeball(eye: .Right).fill()
        pathForMouth().stroke()
        
        
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 2.6
        static let SkullRadiusToEyeRadius: CGFloat = 2.9
        static let EyeRadiusToEyeballRadius:CGFloat = 1.6
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 1
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    

}
