//
//  ViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/13.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate,arrowViewDataSouce {
    
    
    @IBOutlet weak var ball6: UIButton!
    @IBOutlet weak var ball5: UIButton!
    @IBOutlet weak var ball4: UIButton!
    @IBOutlet weak var ball3: UIButton!
    @IBOutlet weak var ball2: UIButton!
    @IBOutlet weak var ball1: UIButton!
    @IBOutlet weak var pushBall: UIButton!
    @IBOutlet weak var hidden: UIButton!
    
    var collision : UICollisionBehavior!
    var collisionWithIdentifier : UICollisionBehavior!
    var animator = UIDynamicAnimator()
    let boundaryWithIdentifierRight = UIView(frame: CGRect(x: 50, y: 20, width: 1, height: 1000))
    let boundaryWithIdentifierLeft = UIView(frame: CGRect(x: 300, y: 20, width: 1, height: 1000))
    
    var arrowPointChange = 0.0{
        didSet {
            updateUI()
        }
    }
    //var arrowPointChange = 0.0
    
    var levelChange = 0{
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        ArrowView.setNeedsDisplay()
    }
    
    func arrowFirstState(sender: arrowView) -> Double? {
        return arrowPointChange
    }
    
    func firstLevel(sender : arrowView) -> Int? {
        return levelChange
    }
    
    @IBOutlet weak var ArrowView: arrowView!{
        didSet{
            ArrowView.dataSource = self
            ArrowView.dataSouceOfLevel = self
        }
    }
    
    
    @IBAction func push(sender: AnyObject) {
        animator.removeAllBehaviors()
        var radian =  ArrowView.bezierPathForArrow(arrowPointChange).radian
        var push = UIPushBehavior(items: [self.pushBall], mode: UIPushBehaviorMode.Continuous)
        push.setAngle(CGFloat( 0.5 * M_PI ) - radian, magnitude: 2)
        animator.addBehavior(push)
        collision = UICollisionBehavior(items: [self.ball1,self.ball2,self.ball3,self.ball4,self.ball5,self.ball6,self.pushBall])
        collision.addBoundaryWithIdentifier("boundaryWithIdentifierRight", forPath: UIBezierPath(rect: boundaryWithIdentifierRight.frame))
        collision.addBoundaryWithIdentifier("boundaryWithIdentifierLeft", forPath: UIBezierPath(rect: boundaryWithIdentifierLeft.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        ArrowView.removeFromSuperview()
    }
    
    
    
    @IBAction func setLevel(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended :fallthrough
        case .Changed :
            let translation = gesture.translationInView(ArrowView)
            let levelEnergy = Int(translation.y)
            if levelChange != 0{
                levelChange += levelEnergy
                gesture.setTranslation(CGPointZero, inView: ArrowView)
            }
        default :break
        }
        
    }
    
    private struct Constants {
        static let arrowMoveLength: CGFloat = 4
    }
    
    @IBAction func SetAngle(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended : fallthrough
        case .Changed:
            let translation = gesture.translationInView(ArrowView)
            let pointChange = -Double(translation.x )
            
            if pointChange != 0.0 {
                arrowPointChange += pointChange
                
                gesture.setTranslation(CGPointZero, inView: ArrowView)
            }
            
        default :break
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        boundaryWithIdentifierRight.backgroundColor = UIColor.redColor()
        boundaryWithIdentifierLeft.backgroundColor = UIColor.redColor()
        
        view.addSubview(boundaryWithIdentifierRight)
        view.addSubview(boundaryWithIdentifierLeft)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        animator = UIDynamicAnimator(referenceView: self.view)
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

