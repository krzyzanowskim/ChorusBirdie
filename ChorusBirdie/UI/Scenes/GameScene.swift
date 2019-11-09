//
//  GameScene.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import AVFoundation
import CoreMotion
import SpriteKit

private let spriteLineCategory: UInt32 = 0x1 << 1

class GameScene: SKScene, SKPhysicsContactDelegate {
  let birdNode = FlyingBirdNode.bird()
  let cable1 = SKSpriteNode(imageNamed: "cable1")
  let cable2 = SKSpriteNode(imageNamed: "cable2")
  var motionManager: CMMotionManager = {
    let mgr = CMMotionManager()
    mgr.deviceMotionUpdateInterval = 2.0 / 60.0
    return mgr
  }()

  var audioPlayer: AVAudioPlayer?

  private var _gameover: Bool = false
  func gameOver(gameOver: Bool) -> Bool {
    self._gameover = gameOver
    if self._gameover {
      if childNode(withName: "GameOverButton") == nil {
        let gameOverButton = SKLabelNode()
        gameOverButton.text = "Game Over"
        gameOverButton.name = "GameOverButton"
        gameOverButton.fontColor = .red
        gameOverButton.fontSize = 80
        gameOverButton.horizontalAlignmentMode = .center
        gameOverButton.position = CGPoint(x: scene!.size.width / 2, y: (scene!.size.height / 3) * 2)
        gameOverButton.zPosition = 5.0
        addChild(gameOverButton)
      }
    } else {
      childNode(withName: "GameOverButton")?.removeFromParent()
      self.reset()
      self.initialSetup()
    }
    return self._gameover
  }

  required override init(size: CGSize) {
    super.init(size: size)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    physicsWorld.contactDelegate = self
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    self.motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
      guard let motion = motion else {
        return
      }
      let x = motion.gravity.x
      let y = motion.gravity.y
      let angle = atan2(y, x) + (.pi / 2)
      // 1.57 is new 0
      let tilt = CGFloat(1.57 - angle)
      if self.birdNode.mode == .landing {
        self.birdNode.physicsBody?.applyImpulse(CGVector(dx: -tilt, dy: 0.0))
        let rotateAction = SKAction.rotate(toAngle: tilt, duration: 0.1)
        self.birdNode.run(rotateAction)
        // SKAction.rotateByAngle(rotateAngleLeft, duration: Double(durationLeft))
      }
    }
  }

  override func didMove(to _: SKView) {
    self.initialSetup()
  }

  func reset() {
    enumerateChildNodes(withName: "bird", using: { (bird: SKNode, _: UnsafeMutablePointer<ObjCBool>) -> Void in
      bird.removeFromParent()
    })
    enumerateChildNodes(withName: "crash", using: { (crash: SKNode, _: UnsafeMutablePointer<ObjCBool>) -> Void in
      crash.removeFromParent()
    })
    enumerateChildNodes(withName: "krakow", using: { (krakow: SKNode, _: UnsafeMutablePointer<ObjCBool>) -> Void in
      krakow.removeFromParent()
    })
    enumerateChildNodes(withName: "cable", using: { (cable: SKNode, _: UnsafeMutablePointer<ObjCBool>) -> Void in
      cable.removeFromParent()
    })
  }

  func initialSetup() {
    physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.9)
    addChild(self.birdNode)
    self.birdNode.position = CGPoint(x: 100, y: 700)
    self.birdNode.physicsBody?.applyForce(CGVector(dx: 3.0, dy: 15.0))

    setupCables()
    buildInitialScene()

    let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpGesture))
    swipeUpGestureRecognizer.direction = .up
    view?.addGestureRecognizer(swipeUpGestureRecognizer)

    let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownGesture))
    swipeDownGestureRecognizer.direction = .down
    view?.addGestureRecognizer(swipeDownGestureRecognizer)

    swipeUpGestureRecognizer.require(toFail: swipeDownGestureRecognizer)
  }

  @objc func swipeDownGesture(recognizer _: UIGestureRecognizer) {
    if !self._gameover {
      if self.birdNode.mode == .flying {
        self.birdNode.mode = .landing
        self.birdNode.physicsBody?.affectedByGravity = true
        self.birdNode.scene?.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.2)
        self.birdNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
      }
    }
  }

  @objc func swipeUpGesture(recognizer _: UIGestureRecognizer) {
    if !self._gameover {
      if self.birdNode.mode == .flying {
        self.birdNode.physicsBody?.applyImpulse(CGVector(dx: 2.5, dy: 20.0))
      }
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      let node = atPoint(location)

      if node.name == "GameOverButton" {
        _ = self.gameOver(gameOver: false)
      }
    }
  }

  override func update(_: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
