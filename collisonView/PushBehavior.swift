//
//  PushBehavior.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/3.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

//import UIKit
//
//class PushBehavior: UIDynamicBehavior {
//    
//    let push = UIPushBehavior(items: [], mode: UIPushBehaviorMode.Continuous)
//    
//    lazy var collider : UICollisionBehavior = {
//        let lazilyCreateCollider = UICollisionBehavior(items: [])
//        lazilyCreateCollider.translatesReferenceBoundsIntoBoundary = true
//        return lazilyCreateCollider
//    }()
//    
//    override init() {
//        super.init()
//        addChildBehavior(push)
//        addChildBehavior(collider)
//        collider.addChildBehavior(push)
//        
//    }
//    
//    func pushObject(object: AnyObject){
//        
//    }
//    
//    func addBarrier(path: UIBezierPath ,named name : String){
//        collider.addBoundaryWithIdentifier(name, forPath: path)
//    }
//    
//    func setAngled(angled: CGFloat){
//        push.setAngle(CGFloat( 0.5 * M_PI ) - angled, magnitude: 2)
//        
//    }
//    
//    func addPush(pushView: UIButton){
//        dynamicAnimator?.referenceView?.addSubview(pushView)
//        push.addItem(pushView)
//        collider.addItem(pushView)
//    }
//    
//    func addPushButton(pushView : UIButton){
//        dynamicAnimator?.referenceView?.addSubview(pushView)
//        collider.addItem(pushView)
//    }
//    
//    func removePush(pushView: UIView){
//        dynamicAnimator?.referenceView?.addSubview(pushView)
//        push.removeItem(pushView)
//        collider.removeItem(pushView)
//    }
//}
