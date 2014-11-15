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
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.addChild(birdNode)
        birdNode.physicsBody?.applyImpulse(CGVectorMake(5.0, 0.0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        birdNode.physicsBody?.applyImpulse(CGVectorMake(0.5, 10.0))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
