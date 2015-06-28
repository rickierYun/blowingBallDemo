//
//  arrowView.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/19.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

protocol arrowViewDataSouce : class {
    func arrowFirstState (sender : arrowView) -> Double?

}

@IBDesignable
class arrowView :UIView {
   
    @IBInspectable
    var color : UIColor = UIColor.blueColor() { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    
    weak var dataSource : arrowViewDataSouce?
    
    private var arrowTop : CGPoint {
        return convertPoint(center, fromView: superview)
        
    }
   
    
    override func drawRect(rect: CGRect) {
        color.set()
        let arrowTopPointByGesture = dataSource?.arrowFirstState(self) ?? 0.0
        bezierPathForArrow(arrowTopPointByGesture).path.stroke()
    }
    
    func bezierPathForArrow (arrowTopPointByGesture : Double) -> (path:UIBezierPath , radian : CGFloat)
    {
        
        let arrowTopPoint = CGPoint(x: arrowTop.x - CGFloat(arrowTopPointByGesture), y: arrowTop.y + 100)
        var arrowLeft = CGPoint(x: arrowTop.x - 15  , y: arrowTop.y + 120)
        var arrowRight = CGPoint(x: arrowTop.x + 15, y: arrowTop.y + 120)
        let arrowBottom = CGPoint(x: arrowTop.x , y: arrowTop.y + 200)
        
        if (arrowTopPointByGesture < 0.0 )
        {
             arrowLeft = CGPoint(x: arrowLeft.x -  CGFloat(arrowTopPointByGesture/1.1) , y: arrowLeft.y)
             arrowRight = CGPoint(x: arrowRight.x - CGFloat(arrowTopPointByGesture/1.5) , y: arrowRight.y )
        }
        else {
             arrowLeft = CGPoint(x: arrowLeft.x - CGFloat(arrowTopPointByGesture/1.5) , y: arrowLeft.y)
             arrowRight = CGPoint(x: arrowRight.x - CGFloat(arrowTopPointByGesture/1.1) , y: arrowRight.y )
        }
       
        let radian = atan2((arrowTopPoint.x - arrowBottom.x), (arrowTopPoint.y - arrowBottom.y))
        
        let path = UIBezierPath()
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowLeft)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowRight)
        path.moveToPoint(arrowTopPoint)
        path.addLineToPoint(arrowBottom)
        path.lineWidth = lineWidth
        return (path, radian)
        
       
    }
    
    
}

