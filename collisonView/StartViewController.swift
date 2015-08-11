//
//  StartViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/10.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "start" {
            let stv = segue.destinationViewController as? loginViewController
        }
        
    }
}
