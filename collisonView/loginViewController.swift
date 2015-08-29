//
//  loginViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/11.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField! { didSet { name.delegate = self}}
    @IBOutlet weak var password: UITextField! {didSet { name.delegate = self}}
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() // show the keyboard first
        return true
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
