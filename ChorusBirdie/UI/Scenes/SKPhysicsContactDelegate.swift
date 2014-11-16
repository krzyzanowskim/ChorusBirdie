//
//  SKPhysicsContactDelegate.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA == birdNode.physicsBody && contact.bodyB == self.cable1.physicsBody && birdNode.mode == .Landing) {
            birdNode.mode = .Sitting
            
            playChorus()
        } else if (contact.bodyA == birdNode.physicsBody && birdNode.mode != .Sitting) {
            let crashStarNode = SKSpriteNode(imageNamed: "crash")
            crashStarNode.position = contact.contactPoint
            self.addChild(crashStarNode)
            gameOver = true
        }
    }

}
