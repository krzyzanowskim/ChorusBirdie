//
//  GameSceneBuild.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit
import UIKit

extension GameScene {
  func setupCables() {
    cable1.position = CGPoint(x: size.width / 2, y: 250)
    cable1.name = "cable"

    if let texture = cable1.texture, let size = cable1.texture?.size() {
      cable1.physicsBody = SKPhysicsBody(texture: texture, size: size)
    }
    cable1.physicsBody?.isDynamic = false
    if cable1.parent == nil {
      addChild(cable1)
    }

    cable2.position = CGPoint(x: size.width / 2, y: 100)
    cable2.name = "cable"

    if let texture = cable2.texture, let size = cable2.texture?.size() {
      cable2.physicsBody = SKPhysicsBody(texture: texture, size: size)
    }
    cable2.physicsBody?.isDynamic = false
    if cable2.parent == nil {
      addChild(cable2)
    }

    let krakow = SKSpriteNode(imageNamed: "krakow")
    krakow.name = "krakow"
    krakow.position = scene!.position
    krakow.size = size
    krakow.zPosition = -1
    addChild(krakow)
  }

  func buildInitialScene() {
    // cable 1
    for idx in stride(from: 150, through: scene!.size.width, by: 140) {
      let skipNext = arc4random_uniform(2) == 0
      if !skipNext {
        let sittingBird = FlyingBirdNode.bird(mode: .Sitting, position: CGPoint(x: idx, y: 700))
        if let body = self.physicsWorld.body(alongRayStart: sittingBird.position, end: CGPoint(x: sittingBird.position.x, y: 0)) {
          if let node = body.node {
            let size = node.calculateAccumulatedFrame()
            sittingBird.position = CGPoint(x: sittingBird.position.x, y: node.position.y + size.height /* + (size.height * node.yScale * 0.5)*/ )
          }
        }
        addChild(sittingBird)
      }
    }

    // cable 2
    for idx in stride(from: 150, through: scene!.size.width, by: 170) {
      if let body = self.physicsWorld.body(alongRayStart: CGPoint(x: idx, y: 100), end: CGPoint(x: idx, y: 0)) {
        if let node = body.node {
          let sittingBird = FlyingBirdNode.bird(mode: .Sitting, position: CGPoint(x: idx, y: 150))
          _ = node.calculateAccumulatedFrame()
          addChild(sittingBird)
        }
      }
    }
  }
}
