//
//  GameScene.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let birdNode = FlyingBirdNode.bird()
    let cable1 = SKSpriteNode(imageNamed: "cable1")
    let cable2 = SKSpriteNode(imageNamed: "cable2")
    let cable3 = SKSpriteNode(imageNamed: "cable3")
    let cable4 = SKSpriteNode(imageNamed: "cable4")

    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.setupCables()

        self.addChild(birdNode)
        birdNode.physicsBody?.applyImpulse(CGVectorMake(5.0, 0.0))
        birdNode.animated = true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        birdNode.physicsBody?.applyImpulse(CGVectorMake(0.5, 10.0))
        
        if birdNode.mode == .Landing {
            birdNode.mode = .Flying
        } else {
            birdNode.mode = .Landing
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setupCables() {
        cable1.position = CGPointMake(self.size.width / 2 + 50, 300);
        cable2.position = CGPointMake(self.size.width / 2, 200);
        cable3.position = CGPointMake(self.size.width / 2, 120);
        cable4.position = CGPointMake(self.size.width / 2, 50);
        
        self.addChild(cable1)
        self.addChild(cable2)
        self.addChild(cable3)
        self.addChild(cable4)
    }
}
