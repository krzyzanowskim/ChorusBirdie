//
//  FlyingBirdNode.swift
//  ChorusBirdie
//
//  Created by Konrad Szczesniak on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit


class FlyingBirdNode : SKSpriteNode {
    
    var topWing: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "flying-bird-wing-up")
        node.anchorPoint = CGPointMake(0, 0)
        return node
    }()
    
    var bottomWing: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "flying-bird-wing-down")
        node.anchorPoint = CGPointMake(1, 1)
        return node
    }()
    
    class func bird() -> FlyingBirdNode {
        let node = FlyingBirdNode()
        
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: node.texture, size: node.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
        }
        
        return node
    }
   
    override init() {
        let birdTexture = SKTexture(imageNamed: "flying-bird-body")
        super.init(texture: birdTexture, color: UIColor.whiteColor(), size: birdTexture.size())
        self.addChild(topWing)
        self.addChild(bottomWing)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimatingWings() {
        let toTheRight = SKAction.rotateByAngle(0.5, duration: 0.2)
        let toTheLeft = SKAction.rotateByAngle(-0.5, duration: 0.2)
        let topSequence = SKAction.sequence([toTheRight, toTheLeft])
        let bottomSequence = SKAction.sequence([toTheLeft, toTheRight])
        
        self.topWing.runAction(SKAction.repeatActionForever(topSequence))
        self.bottomWing.runAction(SKAction.repeatActionForever(bottomSequence))
    }
    
    func stopAnimatingWings() {
        self.topWing.removeAllActions()
        self.bottomWing.removeAllActions()
    }
    
}
