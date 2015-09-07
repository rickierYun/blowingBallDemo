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
    @IBOutlet weak var imageView: UIImageView!
    
    var imageArry = NSMutableArray()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() // show the keyboard first
        return true
    }
//MARK: transmitNameToTitile
//将写好的名字传送游戏界面的title
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
//添加一个gif播放的imageView
    override func viewDidLoad() {
        super.viewDidLoad()
        for(var i = 1 ; i <= 11 ; i++){
            var gif = UIImage(named: "\(i)")!
            imageArry.addObject(gif)
        }
        imageView.animationImages = imageArry as [AnyObject]
        imageView.animationDuration = 2
        imageView.startAnimating()
    }
    
}
