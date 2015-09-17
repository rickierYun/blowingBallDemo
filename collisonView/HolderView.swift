//
//  HolderView.swift
//  SBLoader
//
//  Created by 欧阳云慧 on 15/9/13.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
    func animateLabel()
}

class HolderView: UIView {
    
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
    
    var parentFrame :CGRect = CGRectZero
    weak var delegate:HolderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

//MARK: addOval
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "wobbleOval",userInfo: nil, repeats: false)
    }
    
//MARK: wobbleOval
//摇晃动作实例化
    func wobbleOval() {
        layer.addSublayer(triangleLayer)
        ovalLayer.wobble()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self,selector: "drawAnimatedTriangle", userInfo: nil,repeats: false)
        
    }
    
    func drawAnimatedTriangle() {
        triangleLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: "spinAndTransform",
            userInfo: nil, repeats: false)

    }

//MARK: spinAndTransform
//让生出的角进行旋转变形
    func spinAndTransform() {
        // 更新层的锚点到略微靠近视图中间的下方。这提供了一个看上去更加自然的旋转。这是由于椭圆和三角形事实上比视图中心在垂直方向上略微偏移。因此，如果视图围绕中心旋转，椭圆和三角形可能会垂直方向移动
        layer.anchorPoint = CGPointMake(0.5, 0.6)
        
        // 应用一个CABasicAnimation类来对层做360度旋转，或者2*pi的弧度。旋转是围绕着Z轴，Z轴就是穿过屏幕，垂直于屏幕
        var rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        
        // 在OvalLayer中调用contract()来展示动画，这个动画会削减椭圆的尺寸直到消失
        ovalLayer.contract()
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self,selector: "drawRedAnimatedRectangle",userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self,selector: "drawBlueAnimatedRectangle",userInfo: nil, repeats: false)
        
    }

//MARK: drawRectangle
    func drawRedAnimatedRectangle() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(Colors.red)
    }
    
    func drawBlueAnimatedRectangle() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(Colors.blue)
        NSTimer.scheduledTimerWithTimeInterval(0.40, target: self, selector: "drawArc",userInfo: nil, repeats: false)
    }

//MARK: drawarc
    func drawArc() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.90, target: self, selector: "expandView",userInfo: nil, repeats: false)
    }
    
//MARK: expandView
    func expandView() {
        backgroundColor = Colors.blue
        
        // 帧扩展到你稍早时候添加的RectangleLayer矩形层的描边宽度
        frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth,
            frame.origin.y - blueRectangleLayer.lineWidth,
            frame.size.width + blueRectangleLayer.lineWidth * 2,
            frame.size.height + blueRectangleLayer.lineWidth * 2)
        
        layer.sublayers = nil
        
        // 添加动画，并扩张HolderView填充屏幕，当动画结束的时候，调用addLabel()
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.frame = self.parentFrame
            }, completion: { finished in
                self.addLabel()
        })
    }
    
    func addLabel() {
        delegate?.animateLabel()
    }
}
