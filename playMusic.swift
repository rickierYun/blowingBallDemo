//
//  playMusic.swift
//  collisonView
//
//  Created by 欧阳云慧 on 15/9/3.
//  Copyright (c) 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import AVFoundation

class playMusic: AVAudioPlayer {
//  添加一个音乐播放器
    var audioPlay : AVAudioPlayer!
//  MARK: playMusic
//  定义一个播放函数,播放碰撞声音
    func playMusic(sender: String){
        let musicPath = NSBundle.mainBundle().pathForResource(sender, ofType: "mp3")
        let url = NSURL(fileURLWithPath: musicPath!)
//  swift 2.0 error change try
//  不必写do ，catch try？已经可以防止出错
        
        audioPlay = try? AVAudioPlayer(contentsOfURL: url)
        audioPlay.numberOfLoops = 0
        audioPlay.volume = 0.5
        audioPlay.prepareToPlay()
        audioPlay.play()
    }
}
