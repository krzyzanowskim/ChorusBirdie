//
//  GameScene.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit
import AVFoundation

private let spriteLineCategory:UInt32 = 0x1 << 1;

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let birdNode = FlyingBirdNode.bird()
    let cable1 = SKSpriteNode(imageNamed: "cable1")
    let cable2 = SKSpriteNode(imageNamed: "cable2")
    let cable3 = SKSpriteNode(imageNamed: "cable3")
    let cable4 = SKSpriteNode(imageNamed: "cable4")
    
    var audioPlayer:AVAudioPlayer?
    var gameOver:Bool = false {
        didSet {
            self.childNodeWithName("button")?.removeFromParent()
            let label = SKLabelNode(text: "Game Over")
            label.fontColor = UIColor.redColor()
            label.fontSize = 80
            label.horizontalAlignmentMode = .Center
            label.position = CGPointMake(self.scene!.size.width / 2, (self.scene!.size.height / 3) * 2)
            label.zPosition = 5.0;
            self.addChild(label)
        }
    }
    
    var button:SKLabelNode {
        let button = SKLabelNode(text: "LAND")
        button.name = "button"
        button.fontColor = UIColor.redColor()
        button.fontSize = 80
        button.position = CGPointMake(100, 100)
        button.zPosition = 1.0;
        return button
    }
    
    required override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.9)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(birdNode)

        self.setupCables()
        self.buildInitialScene();

        self.addChild(button)
        birdNode.physicsBody?.applyImpulse(CGVectorMake(10.0, 0.0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            let location = touch.locationInNode(self)
            let node = self .nodeAtPoint(location)
            
            if node.name == "button" {
                birdNode.mode = .Landing
                node.removeFromParent()
            } else {
                // Can touch only when flying
                if !gameOver && birdNode.mode == .Flying {
                    birdNode.physicsBody?.applyImpulse(CGVectorMake(1.5, 10.0))
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
