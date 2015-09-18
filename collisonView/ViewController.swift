//
//  ViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/6/13.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController,UICollisionBehaviorDelegate,ArrowViewDataSouce,UIDynamicAnimatorDelegate{
    
    @IBOutlet weak var ball6: UIButton!
    @IBOutlet weak var ball5: UIButton!
    @IBOutlet weak var ball4: UIButton!
    @IBOutlet weak var ball3: UIButton!
    @IBOutlet weak var ball2: UIButton!
    @IBOutlet weak var ball1: UIButton!
    @IBOutlet weak var pushBall: UIButton!
    
    let pushOneBall = PushBehavior()
    let audioPlay = playMusic()
    
    var collision : UICollisionBehavior!
    var animator = UIDynamicAnimator()
    var number : Int = 0
    var markView: markViewController?
    var titleName: String = "name"
//  定义播放音乐的名字
    struct MusicName {
        static let bmoc = "blowingMusicOfCollison"
        static let pb = "pushBlowing"
        static let edm = "endMusic"
    }
    
//  MARK: PathNames
//  添加自定义边界名字
    struct PathNames {
        static let lb = "boundaryWithIdentifierRight"
        static let rb = "boundaryWithIdentifierLeft"
        static let tb = "boundaryWithIdentifierTop"
    }
    
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
//  初始化 ArrowView的所有数据
    @IBOutlet weak var arrowView: ArrowView!{
        didSet{
            arrowView.dataSource = self
            arrowView.dataSouceOfLevel = self
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
        arrowView?.setNeedsDisplay()
        
    }
    
    func arrowFirstState(sender: ArrowView) -> Double? {
        return arrowPointChange
    }
    
    func firstLevel(sender : ArrowView) -> Int? {
        return levelChange
    }

//  MARK: pushBehavior
//  添加pushBehavior运动
    @IBAction func push(sender: AnyObject) {
        animator.removeAllBehaviors()
        let radian =  arrowView.bezierPathForArrow(arrowPointChange).radian
        let lecb  = CGFloat(arrowView.levelSelect() + 2)
        pushOneBall.addBall(pushBall)
        pushOneBall.setAngled(radian,magnitude: lecb)
        animator.addBehavior(pushOneBall)
        audioPlay.playMusic(MusicName.pb)
        collision = UICollisionBehavior(items: [self.ball1,self.ball2,self.ball3,self.ball4,self.ball5,self.ball6,self.pushBall])
        // 添加自定边界
        collision.addBoundaryWithIdentifier(PathNames.rb, forPath: UIBezierPath(rect: drawbound().lb.frame))
        collision.addBoundaryWithIdentifier(PathNames.lb, forPath: UIBezierPath(rect: drawbound().rb.frame))
        collision.addBoundaryWithIdentifier(PathNames.tb, forPath: UIBezierPath(rect: drawbound().tb.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        arrowView.hidden = true
    }
    
// MARK: collisionBehavior
// 添加碰撞运动
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?){
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
//  设置每个球碰撞时声音,同时帮助pushBall减速
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        if item1 as! UIButton == pushBall{
            let it = item2 as! UIButton
            switch it {
            case ball1:
                audioPlay.playMusic(MusicName.bmoc)
                pushOneBall.slowDown(pushBall)
            case ball2:
                pushOneBall.slowDown(pushBall)
                audioPlay.playMusic(MusicName.bmoc)
            case ball3:
                pushOneBall.slowDown(pushBall)
                audioPlay.playMusic(MusicName.bmoc)
            case ball4:
                pushOneBall.slowDown(pushBall)
                audioPlay.playMusic(MusicName.bmoc)
            case ball5:
                pushOneBall.slowDown(pushBall)
                audioPlay.playMusic(MusicName.bmoc)
            case ball6:
                pushOneBall.slowDown(pushBall)
                audioPlay.playMusic(MusicName.bmoc)
            default: break
            }
        }
    }    
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        animator.removeAllBehaviors()
    }
 
//  MARK: drawboundary
//  绘制边界
    private func drawbound() -> (lb:UIView , rb: UIView, tb: UIView) {
        let boundaryWithIdentifierRight = UIView(frame: CGRect(x: arrowView.bounds.maxX/2 - 100, y: 60, width: 1, height: 1000))
        let boundaryWithIdentifierLeft = UIView(frame: CGRect(x: arrowView.bounds.maxX/2 + 100, y: 60, width: 1, height: 1000))
        let boundaryWithIdentifierTop = UIView(frame: CGRect(x: view!.bounds.maxX/2 - 100 , y: 60, width: 200, height: 1))
       
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
        title = "\(titleName)"
        
    }
    
// MARK: setAngle
// 定义panGestureRecognizer,设置箭头的方向和能量的等级
    @IBAction func setAngle(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended : fallthrough
        case .Changed:
            let translation = gesture.translationInView(arrowView)
            let pointChange = -Double(translation.x )
            
            if pointChange != 0.0 {
                arrowPointChange += pointChange
                gesture.setTranslation(CGPointZero, inView: arrowView)
            }
            let levelEnergy = -Int(translation.y/10)
            if levelEnergy != 0{
                levelChange += levelEnergy
                gesture.setTranslation(CGPointZero, inView: arrowView)
            }
            
        default :break
            
        }
        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewAddbould()
    }
    
//    var refreshController : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshcontroller = UIRefreshControl()
        refreshcontroller.addTarget(self.view, action: "refresh", forControlEvents: UIControlEvents())
        //view.addSubview(refreshController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        animator = UIDynamicAnimator(referenceView: self.view)
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restart(sender: UIButton) {
        arrowView.hidden = false
        arrowView.setNeedsDisplay()
    }
}
