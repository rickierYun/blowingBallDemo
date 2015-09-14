//
//  loginViewController.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/8/11.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate,HolderViewDelegate {
    
    @IBOutlet weak var name: UITextField! { didSet { name.delegate = self}}
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var holderView: HolderView!
    
    var imageArry = NSMutableArray()
    var holderViewFrame = HolderView(frame: CGRectZero)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() // show the keyboard first
        return true
    }
    
 //MARK: addHolderView 
 //添加开始动画
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderViewFrame.frame = CGRect(x: holderView.bounds.width / 2 - boxSize / 2,
            y: holderView.bounds.height / 2 - boxSize / 2,
            width: boxSize,
            height: boxSize)
        holderViewFrame.parentFrame = holderView.frame
        holderViewFrame.delegate = self
        holderView.addSubview(holderViewFrame)
        holderViewFrame.addOval()
    }

//MARK: animateLabel
//添加文字动画
    func animateLabel() {
        holderViewFrame.removeFromSuperview()
        holderView.backgroundColor = Colors.blue
        
        var label: UILabel = UILabel(frame: holderView.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "Party LET", size: 70.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Blowing"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        holderView.addSubview(label)
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: ({
                label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            }), completion: { finished in
                self.addButton()
        })
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, holderView.bounds.width, holderView.bounds.height)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        holderView.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        holderView.removeFromSuperview()
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }
    
}
