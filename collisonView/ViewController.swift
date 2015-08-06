//
//  ViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/13.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate,arrowViewDataSouce,UIDynamicAnimatorDelegate {
    
    
    @IBOutlet weak var ball6: UIButton!
    @IBOutlet weak var ball5: UIButton!
    @IBOutlet weak var ball4: UIButton!
    @IBOutlet weak var ball3: UIButton!
    @IBOutlet weak var ball2: UIButton!
    @IBOutlet weak var ball1: UIButton!
    @IBOutlet weak var pushBall: UIButton!
    
    var collision : UICollisionBehavior!
    var animator = UIDynamicAnimator()
    var number : Int = 0
    
    var arrowPointChange = 0.0{
        didSet {
            updateUI()
        }
    }
    //var arrowPointChange = 0.0
    
    var levelChange = 50{
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
    
    
    struct PathNames {
        static let lb = "boundaryWithIdentifierRight"
        static let rb = "boundaryWithIdentifierLeft"
        static let tb = "boundaryWithIdentifierTop"
    }
    
    @IBAction func push(sender: AnyObject) {
        animator.removeAllBehaviors()
        var radian =  ArrowView.bezierPathForArrow(arrowPointChange).radian
        var lecb  = CGFloat(ArrowView.levelSelect())
        var pushBehavior = UIPushBehavior(items: [self.pushBall], mode: UIPushBehaviorMode.Continuous)
        pushBehavior.setAngle(CGFloat( 0.5 * M_PI ) - radian, magnitude: lecb )
        animator.addBehavior(pushBehavior)
        collision = UICollisionBehavior(items: [self.ball1,self.ball2,self.ball3,self.ball4,self.ball5,self.ball6,self.pushBall])
        collision.addBoundaryWithIdentifier(PathNames.rb, forPath: UIBezierPath(rect: drawbound().lb.frame))
        collision.addBoundaryWithIdentifier(PathNames.lb, forPath: UIBezierPath(rect: drawbound().rb.frame))
        collision.addBoundaryWithIdentifier(PathNames.tb, forPath: UIBezierPath(rect: drawbound().tb.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        ArrowView.hidden = true
        //dynamicAnimatorDidPause(animator)
        //collisionBehavior(collision, endedContactForItem: , withBoundaryIdentifier: NSCopying)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying){
        if identifier as? String == PathNames.tb {
            if item as? UIButton == pushBall {
                behavior.removeItem(pushBall)
                pushBall.hidden = true
            }
            if item as? UIButton == ball6 {
                behavior.removeItem(ball6)
                ball6.hidden = true
                number = number + 1
                println("\(number)")
            }
            if item as? UIButton == ball5 {
                behavior.removeItem(ball5)
                ball5.hidden = true
                number = number + 1
                println("\(number)")
            }
            if item as? UIButton == ball4{
                behavior.removeItem(ball4)
                ball4.hidden = true
                number = number + 1
                println("\(number)")
            }
            if item as? UIButton == ball3 {
                behavior.removeItem(ball3)
                ball3.hidden = true
                number = number + 1
                println("\(number)")
            }
            if item as? UIButton == ball2 {
                behavior.removeItem(ball2)
                ball2.hidden = true
                number = number + 1
                println("\(number)")
            }
            if item as? UIButton == ball1 {
                behavior.removeItem(ball1)
                ball1.hidden = true
                number = number + 1
                println("\(number)")
            }


        }
        println("\(number)")
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        animator.removeAllBehaviors()
    }
    
    private func drawbound() -> (lb:UIView , rb: UIView, tb: UIView) {
        let boundaryWithIdentifierRight = UIView(frame: CGRect(x: ArrowView.bounds.maxX/2 - 100, y: 20, width: 1, height: 1000))
        let boundaryWithIdentifierLeft = UIView(frame: CGRect(x: ArrowView.bounds.maxX/2 + 100, y: 20, width: 1, height: 1000))
        let boundaryWithIdentifierTop = UIView(frame: CGRect(x: view!.bounds.maxX/2 - 100 , y: 20, width: 200, height: 1))
       
        return (boundaryWithIdentifierRight, boundaryWithIdentifierLeft,boundaryWithIdentifierTop)
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
            let levelEnergy = -Int(translation.y/10)
            if levelEnergy != 0{
                levelChange += levelEnergy
                gesture.setTranslation(CGPointZero, inView: ArrowView)
            }
            
        default :break
            
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewAddbould()
    }
    
    func viewAddbould(){
        
        let blf = drawbound().lb
        let brf = drawbound().rb
        let btf = drawbound().tb
        
        blf.backgroundColor = UIColor.redColor()
        brf.backgroundColor = UIColor.redColor()
        //btf.backgroundColor = UIColor.greenColor()
        view.addSubview(blf)
        view.addSubview(brf)
        view.addSubview(btf)

    }
    
    var refreshController : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var refreshcontroller = UIRefreshControl()
        refreshcontroller.addTarget(self.view, action: "refresh", forControlEvents: UIControlEvents())
        //view.addSubview(refreshController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        animator = UIDynamicAnimator(referenceView: self.view)
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restart(sender: AnyObject) {
        ArrowView.hidden = false
//        updateUI()
//        view.addSubview(ArrowView)
        viewDidLoad()
//        viewDidLayoutSubviews()

        refreshController.beginRefreshing()
        refreshController.endRefreshing()
        
    }
    
}
