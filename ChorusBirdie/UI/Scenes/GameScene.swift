//
//  GameScene.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let helloNode = BirdNode.bird()
    
    override func didMoveToView(view: SKView) {
        helloNode.position = CGPointMake(400, 400)
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
