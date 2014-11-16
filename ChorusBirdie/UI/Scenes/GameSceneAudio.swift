//
//  GameSceneAudio.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import Foundation
import AVFoundation

extension GameScene {
    
    
    func playChorus() {
        if let url = NSBundle.mainBundle().URLForResource("chorus", withExtension: "mp3") {
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
            if let audioPlayer = audioPlayer {
                audioPlayer.play()
            } else {
                println(error)
            }
        }
    }
}