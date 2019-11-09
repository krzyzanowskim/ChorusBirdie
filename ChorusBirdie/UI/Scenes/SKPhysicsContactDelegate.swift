//
//  SKPhysicsContactDelegate.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit
import UIKit

extension GameScene {
  func didBeginContact(contact: SKPhysicsContact) {
    if contact.bodyA == birdNode.physicsBody, contact.bodyB == cable1.physicsBody, birdNode.mode == .Landing {
      birdNode.mode = .Sitting

      enumerateChildNodes(withName: "bird", using: { (node, _) -> Void in
        if let bird = node as? FlyingBirdNode {
          bird.swinging = true
        }
      })

      playChorus()
    } else if contact.bodyA == birdNode.physicsBody, birdNode.mode != .Sitting {
      let crashStarNode = SKSpriteNode(imageNamed: "crash")
      crashStarNode.name = "crash"
      crashStarNode.position = contact.contactPoint
      addChild(crashStarNode)
      _ = gameOver(gameOver: true)
    }
  }
}
