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
        self.setupCables()

        self.addChild(birdNode)
        birdNode.physicsBody?.applyImpulse(CGVectorMake(5.0, 0.0))
        birdNode.animated = true
        
        self.addChild(self.button)
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
    
    func setupCables() {
        cable1.position = CGPointMake(self.size.width / 2 + 50, 300);
        cable2.position = CGPointMake(self.size.width / 2, 200);
        cable3.position = CGPointMake(self.size.width / 2, 120);
        cable4.position = CGPointMake(self.size.width / 2, 50);

        self.addChild(cable1)
        self.addChild(cable2)
        self.addChild(cable3)
        self.addChild(cable4)
        
        let cable1texture = SKTexture(imageNamed: "cable1")
        cable1.physicsBody = SKPhysicsBody(texture: cable1texture, size: cable1texture.size())
        cable1.physicsBody?.dynamic = false
        
        let cable2texture = SKTexture(imageNamed: "cable2")
        cable2.physicsBody = SKPhysicsBody(texture: cable2texture, size: cable2texture.size())
        cable2.physicsBody?.dynamic = false
        
        let cable3texture = SKTexture(imageNamed: "cable3")
        cable3.physicsBody = SKPhysicsBody(texture: cable3texture, size: cable3texture.size())
        cable3.physicsBody?.dynamic = false
        
        let cable4texture = SKTexture(imageNamed: "cable4")
        cable4.physicsBody = SKPhysicsBody(texture: cable4texture, size: cable4texture.size())
        cable4.physicsBody?.dynamic = false
    }
}
