//
//  GameSceneAudio.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import AVFoundation
import Foundation

extension GameScene {
  func playChorus() {
    if let url = Bundle.main.url(forResource: "chorus", withExtension: "mp3") {
      do {
        let audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer.play()
      } catch {
        print(error)
      }
    }
  }
}
