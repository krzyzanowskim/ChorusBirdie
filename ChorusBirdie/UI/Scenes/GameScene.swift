//
//  GameScene.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let helloNode: SKSpriteNode = {
        var helloNode = SKSpriteNode(imageNamed: "flying-bird")
        helloNode.position = CGPointMake(400, 400)
        if let physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100)) {
            physicsBody.dynamic = true
            physicsBody.mass = 0.1
            helloNode.physicsBody = physicsBody
        }
        return helloNode
    }()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.addChild(helloNode)
        helloNode.physicsBody?.applyImpulse(CGVectorMake(5.0, 0.0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        helloNode.physicsBody?.applyImpulse(CGVectorMake(0.5, 10.0))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
