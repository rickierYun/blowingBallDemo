//
//  TriangleLayer.swift
//  SBLoader
//
//  Created by 欧阳云慧 on 15/9/12.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
    
    let innerPadding: CGFloat = 30.0
    
    override init!() {
        super.init()
        fillColor = Colors.red.CGColor
        strokeColor = Colors.red.CGColor
        lineWidth = 7.0
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
        path = trianglePathSmall.CGPath
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: triangle
    //绘制三角和变换三角的路径
    var trianglePathSmall: UIBezierPath {
        var trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0 + innerPadding, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLineToPoint(CGPoint(x: 95.0 - innerPadding, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    var trianglePathLeftExtension: UIBezierPath {
        var trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLineToPoint(CGPoint(x: 95.0 - innerPadding, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    var trianglePathRightExtension: UIBezierPath {
        var trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    var trianglePathTopExtension: UIBezierPath {
        var trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5))
        trianglePath.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    //MARK: animate
    //生成三角
    func animate() {
        var triangleAnimationLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationLeft.fromValue = trianglePathSmall.CGPath
        triangleAnimationLeft.toValue = trianglePathLeftExtension.CGPath
        triangleAnimationLeft.beginTime = 0.0
        triangleAnimationLeft.duration = 0.3
        
        var triangleAnimationRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationRight.fromValue = trianglePathLeftExtension.CGPath
        triangleAnimationRight.toValue = trianglePathRightExtension.CGPath
        triangleAnimationRight.beginTime = triangleAnimationLeft.beginTime + triangleAnimationLeft.duration
        triangleAnimationRight.duration = 0.25
        
        var triangleAnimationTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationTop.fromValue = trianglePathRightExtension.CGPath
        triangleAnimationTop.toValue = trianglePathTopExtension.CGPath
        triangleAnimationTop.beginTime = triangleAnimationRight.beginTime + triangleAnimationRight.duration
        triangleAnimationTop.duration = 0.20
        
        var triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        triangleAnimationGroup.animations = [triangleAnimationLeft, triangleAnimationRight,triangleAnimationTop]
        triangleAnimationGroup.duration = triangleAnimationTop.beginTime + triangleAnimationTop.duration
        triangleAnimationGroup.fillMode = kCAFillModeForwards
        triangleAnimationGroup.removedOnCompletion = false
        addAnimation(triangleAnimationGroup, forKey: nil)
    }
}
