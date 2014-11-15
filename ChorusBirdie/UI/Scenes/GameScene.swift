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
        helloNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100))
        helloNode.physicsBody?.dynamic = true
        helloNode.physicsBody?.mass = 0.2
        return helloNode
    }()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.addChild(helloNode)
        helloNode.physicsBody?.applyForce(CGVectorMake(50.0, 0.0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        helloNode.physicsBody?.applyImpulse(CGVectorMake(0.0, 20.0))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
