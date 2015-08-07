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
    var markView: markViewController?

//  MARK: Container
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addMarks" {
            markView = segue.destinationViewController as? markViewController
            addMarks(number)
        }
    }
    
    func addMarks(sender : Int){
        if let marks = markView?.marks{
            marks.text = String(sender)
        }
    }
//  MARK: arrowView
    
    @IBOutlet weak var ArrowView: arrowView!{
        didSet{
            ArrowView.dataSource = self
            ArrowView.dataSouceOfLevel = self
        }
    }

    var arrowPointChange = 0.0{
        didSet {
            updateUI()
        }
    }

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
    
//  MARK: PathNames
    struct PathNames {
        static let lb = "boundaryWithIdentifierRight"
        static let rb = "boundaryWithIdentifierLeft"
        static let tb = "boundaryWithIdentifierTop"
    }
    
//  MARK: pushBehavior
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
    }
    
// MARK: collisionBehavior
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying){
        if identifier as? String == PathNames.tb {
            let ib = item as! UIButton
            switch ib {
            case pushBall :
                behavior.removeItem(ib)
                ib.hidden = true
            case ball1 :
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            case ball2 :
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            case ball3:
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            case ball4:
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            case ball5:
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            case ball6:
                number = number + 1
                behavior.removeItem(ib)
                ib.hidden = true
            default: break
            }

        }
        addMarks(number)
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        animator.removeAllBehaviors()
    }
 
//  MARK: drawboundary
    private func drawbound() -> (lb:UIView , rb: UIView, tb: UIView) {
        let boundaryWithIdentifierRight = UIView(frame: CGRect(x: ArrowView.bounds.maxX/2 - 100, y: 20, width: 1, height: 1000))
        let boundaryWithIdentifierLeft = UIView(frame: CGRect(x: ArrowView.bounds.maxX/2 + 100, y: 20, width: 1, height: 1000))
        let boundaryWithIdentifierTop = UIView(frame: CGRect(x: view!.bounds.maxX/2 - 100 , y: 20, width: 200, height: 1))
       
        return (boundaryWithIdentifierRight, boundaryWithIdentifierLeft,boundaryWithIdentifierTop)
    }
    
    func viewAddbould(){
        
        let blf = drawbound().lb
        let brf = drawbound().rb
        let btf = drawbound().tb
        
        blf.backgroundColor = UIColor.redColor()
        brf.backgroundColor = UIColor.redColor()
        view.addSubview(blf)
        view.addSubview(brf)
        view.addSubview(btf)
        
    }
    
//  MARK : set angle and level
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
//        viewDidLoad()
//        viewDidLayoutSubviews()

//        refreshController.beginRefreshing()
//        refreshController.endRefreshing()
        
    }
    
}
