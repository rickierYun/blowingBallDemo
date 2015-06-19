//
//  arrowView.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/19.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import Foundation
import UIKit

protocol arrowViewSource : class {
    func viewForArrowView ( sender : arrowView) -> Double?
}

class arrowView :UIView {
    private var arrowTop : CGPoint { return convertPoint(center, fromView: superview)}
    
    @IBInspectable
    var color : UIColor = UIColor.blueColor()
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        bezierPathForArrow().stroke()
    }
    private func bezierPathForArrow () -> UIBezierPath
    {
        let arrowTopPoint = CGPoint(x: arrowTop.x , y: arrowTop.y - 100)
        let arrowTopLeft = CGPoint(x: arrowTop.x + 50 , y: arrowTop.y - 120)
        let arrowTopRight = CGPoint(x: arrowTop.x - 50 , y: arrowTop.y - 120)
        let arrowBottom = CGPoint(x: arrowTop.x , y: arrowTop.y - 200)
        
        let path = UIBezierPath()
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowTopLeft)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowTopRight)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowBottom)
        
        return path
    }
}
