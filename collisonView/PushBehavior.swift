//
//  PushBehavior.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/3.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit
//  定义pushBehavior 类 ：添加阻力和碰撞是增加阻力
class PushBehavior: UIDynamicBehavior {
    var push : UIPushBehavior = {
        let lazyPush = UIPushBehavior()
        return lazyPush
    }()
    
    // 添加阻力
    var itemResistance: UIDynamicItemBehavior =  {
        let item = UIDynamicItemBehavior()
        item.resistance = 2
        return item
    }()
    
    //碰撞时增加阻力
    var itemFriction: UIDynamicItemBehavior = {
        let item = UIDynamicItemBehavior()
        item.resistance = 3
        return item
    }()
    
    override init() {
        super.init()
        addChildBehavior(push)
        addChildBehavior(itemResistance)
        addChildBehavior(itemFriction)
    }
    
    func addBall(sender: UIButton)  {
        push.addItem(sender)
        itemResistance.addItem(sender)
    }
    
    func slowDown (sender: UIButton){
        itemFriction.addItem(sender)
    }
    
    func setAngled(angled: CGFloat,magnitude: CGFloat){
        push.setAngle(CGFloat( 0.5 * M_PI ) - angled, magnitude: magnitude)
        
    }

}
