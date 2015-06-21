//
//  arrowView.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/19.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class arrowView :UIView {
   
    @IBInspectable
    var color : UIColor = UIColor.blueColor() { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    
    private var arrowTop : CGPoint { return convertPoint(center, fromView: superview)}
    override func drawRect(rect: CGRect) {
        color.set()
        bezierPathForArrow().stroke()
    }
    private func bezierPathForArrow () -> UIBezierPath
    {
        let arrowTopPoint = CGPoint(x: arrowTop.x , y: arrowTop.y + 100)
        let arrowTopLeft = CGPoint(x: arrowTop.x - 15 , y: arrowTop.y + 120)
        let arrowTopRight = CGPoint(x: arrowTop.x + 15 , y: arrowTop.y + 120)
        let arrowBottom = CGPoint(x: arrowTop.x , y: arrowTop.y + 200)
        
        let path = UIBezierPath()
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowTopLeft)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowTopRight)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowBottom)
        color.set()
        path.lineWidth = lineWidth
        return path
    }
}

