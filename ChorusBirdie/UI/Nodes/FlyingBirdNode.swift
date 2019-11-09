//
//  FlyingBirdNode.swift
//  ChorusBirdie
//
//  Created by Konrad Szczesniak on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import AVFoundation
import SpriteKit
import UIKit

let spriteBirdCategory: UInt32 = 0x1 << 0

class FlyingBirdNode: SKEffectNode {
  var audioPlayer: AVAudioPlayer = {
    let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "kwakwa", withExtension: "mp3")!)
    return player
  }()

  var mode: ModeEnum = .flying {
    didSet {
      self.setupSprites()

      switch self.mode {
        case .landing, .sitting:
          childNode(withName: "leftWing")?.zRotation = .pi / 2
          childNode(withName: "rightWing")?.zRotation = .pi / 2
          self.audioPlayer.stop()
        case .flying:
          childNode(withName: "leftWing")?.zRotation = 0
          childNode(withName: "rightWing")?.zRotation = 0

          self.playKwakKwak()
      }

      shouldEnableEffects = self.mode == .sitting
    }
  }

  var greyFilter: CIFilter {
    CIFilter(name: "CIColorControls", parameters: ["inputBrightness": 0.0, "inputSaturation": 0.0])!
  }

  var animated: Bool = false {
    didSet {
      if self.animated {
        self.startAnimatingWings()
      } else {
        self.stopAnimatingWings()
      }
    }
  }

  var swinging: Bool = false {
    didSet {
      if self.swinging {
        self.startSwinging()
      } else {
        self.stopSwinging()
      }
    }
  }

  private var kwaTimer: Timer?

  @objc func playKwakKwak() {
    self.audioPlayer.play()

    self.kwaTimer?.invalidate()
    self.kwaTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.playKwakKwak), userInfo: nil, repeats: false)
  }

  class func bird(mode: ModeEnum = .flying, animated: Bool = true, position: CGPoint = CGPoint(x: 100, y: 700)) -> FlyingBirdNode {
    let node = FlyingBirdNode()
    node.position = position
    node.mode = mode
    node.animated = animated
    node.name = "bird"
    let bodyNode = node.mode.body

    if let texture = bodyNode.texture {
      node.physicsBody = SKPhysicsBody(texture: texture, size: bodyNode.size)
      node.physicsBody?.isDynamic = true
      node.physicsBody?.mass = 0.1
      node.physicsBody?.allowsRotation = false
      node.physicsBody?.categoryBitMask = spriteBirdCategory
      node.physicsBody?.contactTestBitMask = spriteBirdCategory
    }
    return node
  }

  override init() {
    super.init()
    shouldEnableEffects = false
    filter = self.greyFilter
    self.setupSprites()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  private func startAnimatingWings() {
    var durationLeft: CGFloat
    var durationRight: CGFloat
    var rotateAngleLeft: CGFloat
    var rotateAngleRight: CGFloat

    switch self.mode {
      case .flying:
        rotateAngleLeft = 0.5
        rotateAngleRight = 0.5
        durationLeft = 0.2 + CGFloat(arc4random_uniform(10)) / 100.0
        durationRight = 0.2 + CGFloat(arc4random_uniform(10)) / 100.0
      default:
        rotateAngleLeft = 0.1 + CGFloat(arc4random_uniform(1)) / 100.0
        rotateAngleRight = 0.1 + CGFloat(arc4random_uniform(1)) / 100.0
        durationLeft = 0.5 + CGFloat(arc4random_uniform(10)) / 100.0
        durationRight = 0.5 + CGFloat(arc4random_uniform(10)) / 100.0
    }

    let toTheRight = SKAction.rotate(byAngle: rotateAngleLeft, duration: Double(durationLeft))
    let toTheLeft = SKAction.rotate(byAngle: -rotateAngleRight, duration: Double(durationRight))
    let topSequence = SKAction.sequence([toTheRight, toTheLeft])
    let bottomSequence = SKAction.sequence([toTheLeft, toTheRight])

    childNode(withName: "leftWing")?.run(SKAction.repeatForever(topSequence))
    childNode(withName: "rightWing")?.run(SKAction.repeatForever(bottomSequence))
  }

  private func stopAnimatingWings() {
    childNode(withName: "leftWing")?.removeAllActions()
    childNode(withName: "rightWing")?.removeAllActions()
  }

  private func startSwinging() {
    let firstAction = SKAction.rotate(byAngle: 0.25, duration: 0.25)

    let leftRotation = SKAction.rotate(byAngle: -0.5, duration: 0.5)
    let leftMove = SKAction.moveBy(x: self.mode.body.size.width / 2, y: 0, duration: 0.5)
    let toTheLeft = SKAction.group([leftRotation, leftMove])

    let rightRotation = SKAction.rotate(byAngle: 0.5, duration: 0.5)
    let rightMove = SKAction.moveBy(x: -self.mode.body.size.width / 2, y: 0, duration: 0.5)
    let toTheRight = SKAction.group([rightRotation, rightMove])

    let sequence = SKAction.repeatForever(SKAction.sequence([toTheLeft, toTheRight]))
    sequence.timingMode = SKActionTimingMode.easeIn
    run(SKAction.sequence([firstAction, sequence]))
  }

  private func stopSwinging() {}

  func setupSprites() {
    removeAllChildren()
    addChild(self.mode.body)
    addChild(self.mode.leftWing)
    addChild(self.mode.righWing)
  }
}
