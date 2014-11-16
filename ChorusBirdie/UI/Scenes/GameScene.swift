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
            let label = SKLabelNode(text: "Game Over")
            label.fontColor = UIColor.redColor()
            label.fontSize = 80
            label.horizontalAlignmentMode = .Center
            label.position = CGPointMake(self.scene!.size.width / 2, (self.scene!.size.height / 3) * 2)
            label.zPosition = 5.0;
            self.addChild(label)
        }
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

        birdNode.physicsBody?.applyImpulse(CGVectorMake(5.0, 3.0))
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipeUpGesture:"))
        swipeUpGestureRecognizer.direction = .Up
        self.view?.addGestureRecognizer(swipeUpGestureRecognizer)

        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipeDownGesture:"))
        swipeDownGestureRecognizer.direction = .Down
        self.view?.addGestureRecognizer(swipeDownGestureRecognizer)

        swipeUpGestureRecognizer.requireGestureRecognizerToFail(swipeDownGestureRecognizer)
    }

    func swipeDownGesture(recognizer: UIGestureRecognizer) {
        if (!gameOver) {
            if (birdNode.mode == .Flying) {
                birdNode.mode = .Landing
                birdNode.physicsBody?.applyImpulse(CGVectorMake(-2.5, 0.0))
            }
        }
    }

    func swipeUpGesture(recognizer: UIGestureRecognizer) {
        if (!gameOver) {
            if (birdNode.mode == .Flying) {
                birdNode.physicsBody?.applyImpulse(CGVectorMake(1.5, 20.0))
            }
        }
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        if let touch = touches.anyObject() as? UITouch {
//            let location = touch.locationInNode(self)
//            let node = self.nodeAtPoint(location)
//        }
//    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
