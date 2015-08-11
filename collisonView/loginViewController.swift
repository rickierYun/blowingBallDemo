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
        if let loginStart = segue.destinationViewController as? ViewController {
            if segue.identifier == "login" {
                loginStart.title = name.text
            }
            
        }
    }

    
}
