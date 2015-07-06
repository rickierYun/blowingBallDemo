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
    func firstLevel(sender: arrowView) -> Int?
}

@IBDesignable
class arrowView :UIView {
    
    @IBInspectable
    var color : UIColor = UIColor.blueColor() { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    var colorGreen : UIColor = UIColor.greenColor() { didSet{ setNeedsDisplay()}}
    var grayColor : UIColor = UIColor.grayColor() { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lightYellowColor : UIColor = UIColor.yellowColor() {didSet{ setNeedsDisplay()}}
    var yellowColor : UIColor = UIColor.yellowColor() { didSet{ setNeedsDisplay()}}
    var organeColor : UIColor = UIColor.orangeColor() {didSet{ setNeedsDisplay()}}
    var redColor : UIColor = UIColor.redColor() {didSet{ setNeedsDisplay()}}
    weak var dataSource : arrowViewDataSouce?
    weak var dataSouceOfLevel : arrowViewDataSouce?
    
    private var viewCenter : CGPoint {
        return convertPoint(center, fromView: superview)
        
    }
    
    
    override func drawRect(rect: CGRect) {
        color.set()
        let arrowTopPointByGesture = dataSource?.arrowFirstState(self) ?? 0.0
        bezierPathForArrow(arrowTopPointByGesture).path.stroke()
        let levelEnergChangeByGesture = dataSouceOfLevel?.firstLevel(self) ?? 0
        switch levelEnergChangeByGesture{
        case 0..<1 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            grayColor.set()
            secondaryLevelOfEnergy().stroke()
            thirdLevelOfEnergy().stroke()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 1..<2 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            grayColor.set()
            thirdLevelOfEnergy().stroke()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 2..<3 :
            colorGreen.set()
            fifthLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            yellowColor.set()
            thirdLevelOfEnergy().stroke()
            grayColor.set()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 3..<4 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            yellowColor.set()
            thirdLevelOfEnergy().stroke()
            organeColor.set()
            forthLevelOfEnergy().stroke()
            grayColor.set()
            fifthLevelOfEnergy().stroke()
        case 4..<50 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            yellowColor.set()
            thirdLevelOfEnergy().stroke()
            organeColor.set()
            forthLevelOfEnergy().stroke()
            redColor.set()
            fifthLevelOfEnergy().stroke()
        default : break
        }
    }
    
    func bezierPathForArrow (arrowTopPointByGesture : Double) -> (path:UIBezierPath , radian : CGFloat)
    {
        
        let arrowTopPoint = CGPoint(x: viewCenter.x - CGFloat(arrowTopPointByGesture), y: viewCenter.y + 100 )
        var arrowLeft = CGPoint(x: viewCenter.x - 15  , y: viewCenter.y + 120)
        var arrowRight = CGPoint(x: viewCenter.x + 15, y: viewCenter.y + 120)
        let arrowBottom = CGPoint(x: viewCenter.x , y: viewCenter.y + 180)
        
        if (arrowTopPointByGesture < 0.0 )
        {
            arrowLeft = CGPoint(x: arrowLeft.x -  CGFloat(arrowTopPointByGesture/1.1) , y: arrowLeft.y )
            arrowRight = CGPoint(x: arrowRight.x - CGFloat(arrowTopPointByGesture/1.5) , y: arrowRight.y )
        }
        else {
            arrowLeft = CGPoint(x: arrowLeft.x - CGFloat(arrowTopPointByGesture/1.5) , y: arrowLeft.y )
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
    private func firstLevelOfEnergy() -> UIBezierPath
    {
        let firstLevelStartPoint = CGPoint(x: viewCenter.x - 200 , y: viewCenter.y - 200)
        let firstLevelEndingPoint = CGPoint(x: viewCenter.x - 150 , y: viewCenter.y - 200)
        let path = UIBezierPath()
        path.moveToPoint(firstLevelStartPoint)
        path.addLineToPoint(firstLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func secondaryLevelOfEnergy() -> UIBezierPath
    {
        let secondaryLevelStartPoint = CGPoint(x: viewCenter.x - 200 , y: viewCenter.y - 210)
        let secondaryLevelEndingPoint = CGPoint(x: viewCenter.x - 120 , y: viewCenter.y - 210)
        let path = UIBezierPath()
        path.moveToPoint(secondaryLevelStartPoint)
        path.addLineToPoint(secondaryLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func thirdLevelOfEnergy() -> UIBezierPath
    {
        let thirdLevelStartPoint = CGPoint(x: viewCenter.x - 200 , y: viewCenter.y - 220)
        let thirdLevelEndingPoint = CGPoint(x: viewCenter.x - 100 , y: viewCenter.y - 220)
        let path = UIBezierPath()
        path.moveToPoint(thirdLevelStartPoint)
        path.addLineToPoint(thirdLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func forthLevelOfEnergy() -> UIBezierPath
    {
        let forthLevelStartPoint = CGPoint(x: viewCenter.x - 200, y: viewCenter.y - 230)
        let forthLevelEndingPoint = CGPoint(x: viewCenter.x - 80, y: viewCenter.y - 230)
        let path = UIBezierPath()
        path.moveToPoint(forthLevelStartPoint)
        path.addLineToPoint(forthLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func fifthLevelOfEnergy() -> UIBezierPath
    {
        let fifthLevelStartPoint = CGPoint(x: viewCenter.x - 200 , y: viewCenter.y - 240)
        let fifThLevelEndingPoint = CGPoint(x: viewCenter.x - 60 , y: viewCenter.y - 240)
        let path = UIBezierPath()
        path.moveToPoint(fifthLevelStartPoint)
        path.addLineToPoint(fifThLevelEndingPoint)
        
        path.lineWidth = 10
        return path
    }
    
}

