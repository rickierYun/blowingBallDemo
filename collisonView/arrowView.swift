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
    
    private var viewButtom: CGFloat {
        let buttom = superview!.bounds.maxY - 80
        return buttom
    }
    
    private var leftBound: CGFloat {
        let left = superview!.bounds.minX + 10
        return left
    }
    
    override func drawRect(rect: CGRect) {
        color.set()
        let arrowTopPointByGesture = dataSource?.arrowFirstState(self) ?? 0.0
        bezierPathForArrow(arrowTopPointByGesture).path.stroke()
        let levelEnergChangeByGesture = dataSouceOfLevel?.firstLevel(self) ?? 0
        switch levelEnergChangeByGesture{
        case 0..<51 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            grayColor.set()
            secondaryLevelOfEnergy().stroke()
            thirdLevelOfEnergy().stroke()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 51..<60 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            grayColor.set()
            thirdLevelOfEnergy().stroke()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 60..<70 :
            colorGreen.set()
            firstLevelOfEnergy().stroke()
            lightYellowColor.set()
            secondaryLevelOfEnergy().stroke()
            yellowColor.set()
            thirdLevelOfEnergy().stroke()
            grayColor.set()
            forthLevelOfEnergy().stroke()
            fifthLevelOfEnergy().stroke()
        case 70..<80 :
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
        case 80..<100 :
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
        
        let arrowTopPoint = CGPoint(x: viewCenter.x - CGFloat(arrowTopPointByGesture), y: viewButtom - 80 )
        var arrowLeft = CGPoint(x: viewCenter.x - 15  , y: viewButtom - 60)
        var arrowRight = CGPoint(x: viewCenter.x + 15, y: viewButtom - 60)
        let arrowBottom = CGPoint(x: viewCenter.x , y: viewButtom)
        
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
        let firstLevelStartPoint = CGPoint(x: leftBound , y: viewCenter.y )
        let firstLevelEndingPoint = CGPoint(x: leftBound + 50 , y: viewCenter.y)
        let path = UIBezierPath()
        path.moveToPoint(firstLevelStartPoint)
        path.addLineToPoint(firstLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func secondaryLevelOfEnergy() -> UIBezierPath
    {
        let secondaryLevelStartPoint = CGPoint(x: leftBound , y: viewCenter.y - 10)
        let secondaryLevelEndingPoint = CGPoint(x: leftBound + 60 , y: viewCenter.y - 10)
        let path = UIBezierPath()
        path.moveToPoint(secondaryLevelStartPoint)
        path.addLineToPoint(secondaryLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func thirdLevelOfEnergy() -> UIBezierPath
    {
        let thirdLevelStartPoint = CGPoint(x: leftBound  , y: viewCenter.y - 20)
        let thirdLevelEndingPoint = CGPoint(x: leftBound + 70 , y: viewCenter.y - 20)
        let path = UIBezierPath()
        path.moveToPoint(thirdLevelStartPoint)
        path.addLineToPoint(thirdLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func forthLevelOfEnergy() -> UIBezierPath
    {
        let forthLevelStartPoint = CGPoint(x: leftBound , y: viewCenter.y - 30)
        let forthLevelEndingPoint = CGPoint(x: leftBound + 80, y: viewCenter.y - 30)
        let path = UIBezierPath()
        path.moveToPoint(forthLevelStartPoint)
        path.addLineToPoint(forthLevelEndingPoint)
        path.lineWidth = 10
        return path
    }
    
    private func fifthLevelOfEnergy() -> UIBezierPath
    {
        let fifthLevelStartPoint = CGPoint(x: leftBound  , y: viewCenter.y - 40)
        let fifThLevelEndingPoint = CGPoint(x: leftBound + 90 , y: viewCenter.y - 40)
        let path = UIBezierPath()
        path.moveToPoint(fifthLevelStartPoint)
        path.addLineToPoint(fifThLevelEndingPoint)
        
        path.lineWidth = 10
        return path
    }
    
}

