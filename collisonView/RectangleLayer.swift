//
//  RectangleLayer.swift
//  SBLoader
//
//  Created by 欧阳云慧 on 15/9/13.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
  
  override init() {
    super.init()
    fillColor = Colors.clear.CGColor
    lineWidth = 5.0
    path = rectanglePathFull.CGPath
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
//MARK: rectangle
//绘制长方形作为容器
  var rectanglePathFull: UIBezierPath {
    let rectanglePath = UIBezierPath()
    rectanglePath.moveToPoint(CGPoint(x: 0.0, y: 100.0))
    rectanglePath.addLineToPoint(CGPoint(x: 0.0, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
    rectanglePath.addLineToPoint(CGPoint(x: -lineWidth / 2, y: 100.0))
    rectanglePath.closePath()
    return rectanglePath
  }

//MARK: animateStroke
//绘制容器动画
  func animateStrokeWithColor(color: UIColor) {
    strokeColor = color.CGColor
    let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeAnimation.fromValue = 0.0
    strokeAnimation.toValue = 1.0
    strokeAnimation.duration = 0.4
    addAnimation(strokeAnimation, forKey: nil)
  }
}
