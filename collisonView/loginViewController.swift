//
//  loginViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/11.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {   
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nation = segue.destinationViewController as? UIViewController
        if let navc = nation as? UINavigationController {
            nation = navc.visibleViewController
        }
        if let loginStart = nation as? ViewController {
            if segue.identifier == "login" {
                loginStart.titleName = name.text
            }
            
        }
    }

    
}
