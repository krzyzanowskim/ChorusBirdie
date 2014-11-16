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

    var audioPlayer:AVAudioPlayer?
    
    private var _gameover:Bool = false
    func gameOver(gameOver:Bool) -> Bool {
        _gameover = gameOver
        if (_gameover) {
            if (self.childNodeWithName("GameOverButton") == nil) {
                let gameOverButton = SKLabelNode()
                gameOverButton.text = "Game Over"
                gameOverButton.name = "GameOverButton"
                gameOverButton.fontColor = UIColor.redColor()
                gameOverButton.fontSize = 80
                gameOverButton.horizontalAlignmentMode = .Center
                gameOverButton.position = CGPointMake(self.scene!.size.width / 2, (self.scene!.size.height / 3) * 2)
                gameOverButton.zPosition = 5.0;
                self.addChild(gameOverButton)
            }
        } else {
            self.childNodeWithName("GameOverButton")?.removeFromParent()
            reset()
            initialSetup()
        }
        return _gameover
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
        initialSetup()
    }
    
    func reset() {
        self.enumerateChildNodesWithName("bird", usingBlock: { (bird:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            bird.removeFromParent()
        })
        self.enumerateChildNodesWithName("crash", usingBlock: { (crash:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            crash.removeFromParent()
        })
        self.enumerateChildNodesWithName("krakow", usingBlock: { (krakow:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            krakow.removeFromParent()
        })
        self.enumerateChildNodesWithName("cable", usingBlock: { (cable:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            cable.removeFromParent()
        })

    }
    
    func initialSetup() {
        birdNode.position = CGPoint(x:100,y:700)
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
        if (!_gameover) {
            if (birdNode.mode == .Flying) {
                birdNode.mode = .Landing
                birdNode.physicsBody?.applyImpulse(CGVectorMake(-2.5, 0.0))
            }
        }
    }

    func swipeUpGesture(recognizer: UIGestureRecognizer) {
        if (!_gameover) {
            if (birdNode.mode == .Flying) {
                birdNode.physicsBody?.applyImpulse(CGVectorMake(1.5, 20.0))
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            let location = touch.locationInNode(self)
            let node = self .nodeAtPoint(location)
            
            if node.name == "GameOverButton" {
                self.gameOver(false)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
