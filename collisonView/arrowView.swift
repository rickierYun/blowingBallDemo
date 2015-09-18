//
//  arrowView.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/19.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

protocol ArrowViewDataSouce : class {
    func arrowFirstState (sender : ArrowView) -> Double?
    func firstLevel(sender: ArrowView) -> Int?
}

//MARK: arrowView
//创建一个视图类，构造箭头和能量等级视图

@IBDesignable
class ArrowView :UIView {
    
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
    weak var dataSource : ArrowViewDataSouce?
    weak var dataSouceOfLevel : ArrowViewDataSouce?
    
//MARK: viewCenter
//寻找本个UIview的中心点
    private var viewCenter : CGPoint {
        return convertPoint(center, fromView: superview)
        
    }
//MARK: viewButtom
//定义箭头的底部与视图底部的距离
    private var viewButtom: CGFloat {
        let buttom = superview!.bounds.maxY - 80
        return buttom
    }
//MARK: leftBound
//定义左边距
    private var leftBound: CGFloat {
        let left = superview!.bounds.minX + 10
        return left
    }
//MARK: drawRect
//绘制箭头和等级
    override func drawRect(rect: CGRect) {
        var i :CGFloat = 1
        var sender : CGFloat = 0
        color.set()
        let arrowTopPointByGesture = dataSource?.arrowFirstState(self) ?? 0.0
        bezierPathForArrow(arrowTopPointByGesture).path.stroke()
        let levelEnergChangeByGesture = dataSouceOfLevel?.firstLevel(self) ?? 0
        switch levelEnergChangeByGesture{
        case 0..<51 :
            colorGreen.set()
            levelOfEnergy(sender).path.stroke()
            grayColor.set()
            while i < 5 {
                sender = i * 10
                levelOfEnergy(sender).path.stroke()
                i += 1
            }
        case 51..<60 :
            colorGreen.set()
            levelOfEnergy(sender).path.stroke()
            lightYellowColor.set()
            levelOfEnergy(sender + 10).path.stroke()
            grayColor.set()
            while i < 4 {
                sender += 10
                sender += i * 10
                levelOfEnergy(sender).path.stroke()
                sender = CGFloat(0)
                i += 1
            }
        case 60..<70 :
            colorGreen.set()
            levelOfEnergy(sender).path.stroke()
            lightYellowColor.set()
            levelOfEnergy(sender + 10).path.stroke()
            yellowColor.set()
            levelOfEnergy(sender + 20).path.stroke()
            grayColor.set()
            while i < 3 {
                sender += 20
                sender += i * 10
                levelOfEnergy(sender).path.stroke()
                sender = CGFloat(0)
                i += 1
            }
        case 70..<80 :
            colorGreen.set()
            levelOfEnergy(sender).path.stroke()
            lightYellowColor.set()
            levelOfEnergy(sender + 10).path.stroke()
            yellowColor.set()
            levelOfEnergy(sender + 20).path.stroke()
            organeColor.set()
            levelOfEnergy(sender + 30).path.stroke()
            grayColor.set()
            levelOfEnergy(sender + 40).path.stroke()
        case 80..<100 :
            colorGreen.set()
            levelOfEnergy(sender).path.stroke()
            lightYellowColor.set()
            levelOfEnergy(sender + 10).path.stroke()
            yellowColor.set()
            levelOfEnergy(sender + 20).path.stroke()
            organeColor.set()
            levelOfEnergy(sender + 30 ).path.stroke()
            redColor.set()
            levelOfEnergy(sender + 40).path.stroke()
        default : break
        }
    }
    
    func levelSelect() -> Int {
        var lecb: Int = 0
        let levelEnergChangeByGesture = dataSouceOfLevel?.firstLevel(self) ?? 0
        switch levelEnergChangeByGesture {
        case 0..<51 :
            lecb = levelOfEnergy(0).level
        case 51..<60 :
            lecb = levelOfEnergy(10).level
        case 60..<70 :
            lecb = levelOfEnergy(20).level
        case 70..<80 :
            lecb = levelOfEnergy(30).level
        case 80..<100 :
            lecb = levelOfEnergy(40).level
        default: break
        }
        
        return lecb
    }
//MARK: bezierPathArrow
//构建箭头的绘制路径，确定其在视图上的位置，保证在所有设备上的地点一致
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
//MARK: levelOfEnergy
//构建能量等级的绘制路径，确定其在view 上的位置，保持其在左上角
    private func levelOfEnergy(sender : CGFloat) -> (path :UIBezierPath, level: Int)
    {
        let levelStartPoint = CGPoint(x: leftBound, y: viewCenter.y - sender)
        let levelEndPoint = CGPoint(x: leftBound + 50 + sender, y: viewCenter.y - sender)
        let path = UIBezierPath()
        path.moveToPoint(levelStartPoint)
        path.addLineToPoint(levelEndPoint)
        path.lineWidth = 10
        
        var level : Int = 1
        if sender == 0 {
            level = 1
        }else{
            level = Int(sender / 10 )
        }
        return (path,level)
    }
    

}

