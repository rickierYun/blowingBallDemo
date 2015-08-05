//
//  BezierPathsView.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/4.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var bezierPaths = [String: UIBezierPath]()
    
    func setPath(path: UIBezierPath? ,named name: String){
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for(_, path) in bezierPaths {
            path.stroke()
        }
    }

}
