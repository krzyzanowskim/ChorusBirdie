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

    var button:SKLabelNode {
        let button = SKLabelNode(text: "LAND")
        button.name = "button"
        button.fontColor = UIColor.redColor()
        button.fontSize = 80
        button.position = CGPointMake(100, 100)
        button.zPosition = 1.0;
        return button
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.addChild(birdNode)

        self.setupCables()
        self.buildInitialScene();
        self.addChild(button)
        
        birdNode.physicsBody?.applyImpulse(CGVectorMake(10.0, 0.0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if let touch = touches.anyObject() as? UITouch {
            let location = touch.locationInNode(self)
            let node = self .nodeAtPoint(location)
            
            if node.name == "button" {
                birdNode.mode = .Landing
                node.removeFromParent()
            } else {
                birdNode.physicsBody?.applyImpulse(CGVectorMake(0.5, 10.0))
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
