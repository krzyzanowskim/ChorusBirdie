//
//  FlyingBirdNode.swift
//  ChorusBirdie
//
//  Created by Konrad Szczesniak on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

let spriteBirdCategory:UInt32 = 0x1 << 0;

class FlyingBirdNode : SKEffectNode {

    var audioPlayer:AVAudioPlayer = {
        var error:NSError?
        let player = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("kwakwa", withExtension: "mp3"), error:&error)
        return player
    }()
    
    var mode:ModeEnum = .Flying {
        didSet {
            self.setupSprites()
            
            switch (mode) {
            case .Landing, .Sitting:
                self.childNodeWithName("leftWing")?.zRotation = CGFloat(M_PI) / 2
                self.childNodeWithName("rightWing")?.zRotation = CGFloat(M_PI) / 2
                audioPlayer.stop()
                break;
            case .Flying:
                self.childNodeWithName("leftWing")?.zRotation = 0
                self.childNodeWithName("rightWing")?.zRotation = 0
                
                playKwakKwak()
                break;
            }
            
            self.shouldEnableEffects = mode == .Sitting
        }
    }
    
    var greyFilter:CIFilter {
        return CIFilter(name: "CIColorControls", withInputParameters: ["inputBrightness": 0.0, "inputSaturation":0.0])
    }
    
    var animated:Bool = false {
        didSet {
            if animated {
                self.startAnimatingWings()
            } else {
                self.stopAnimatingWings()
            }
        }
    }
    
    var swinging:Bool = false {
        didSet {
            if swinging {
                self.startSwinging()
            } else {
                self.stopSwinging()
            }
        }
    }
    
    
    private var kwaTimer:NSTimer? = nil
    func playKwakKwak() {
        audioPlayer.play();
        
        kwaTimer?.invalidate()
        kwaTimer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: Selector("playKwakKwak"), userInfo: nil, repeats: false)
    }
    
    class func bird(mode: ModeEnum = .Flying, animated:Bool = true, position: CGPoint = CGPoint(x:100,y:700)) -> FlyingBirdNode {
        let node = FlyingBirdNode()
        node.position = position
        node.mode    = mode
        node.animated = animated
        node.name    = "bird"
        let bodyNode = node.mode.body
        
        if let texture = bodyNode.texture {
            node.physicsBody = SKPhysicsBody(texture: bodyNode.texture, size: bodyNode.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = spriteBirdCategory
            node.physicsBody?.contactTestBitMask = spriteBirdCategory
        }
        return node
    }
    
    override init() {
        super.init()
        self.shouldEnableEffects = false
        self.filter = greyFilter
        self.setupSprites()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func startAnimatingWings() {
        
        var durationLeft:CGFloat
        var durationRight:CGFloat
        var rotateAngleLeft:CGFloat
        var rotateAngleRight:CGFloat
        
        switch (self.mode) {
        case .Flying:
            rotateAngleLeft = 0.5
            rotateAngleRight = 0.5
            durationLeft = 0.2 + CGFloat(arc4random_uniform(10)) / 100.0
            durationRight = 0.2 + CGFloat(arc4random_uniform(10)) / 100.0
            break;
        default:
            rotateAngleLeft = 0.1 + CGFloat(arc4random_uniform(1)) / 100.0
            rotateAngleRight = 0.1 + CGFloat(arc4random_uniform(1)) / 100.0
            durationLeft = 0.5 + CGFloat(arc4random_uniform(10)) / 100.0
            durationRight = 0.5 + CGFloat(arc4random_uniform(10)) / 100.0
            break
        }
        
        let toTheRight = SKAction.rotateByAngle(rotateAngleLeft, duration: Double(durationLeft))
        let toTheLeft = SKAction.rotateByAngle(-rotateAngleRight, duration: Double(durationRight))
        let topSequence = SKAction.sequence([toTheRight, toTheLeft])
        let bottomSequence = SKAction.sequence([toTheLeft, toTheRight])
        
        self.childNodeWithName("leftWing")?.runAction(SKAction.repeatActionForever(topSequence))
        self.childNodeWithName("rightWing")?.runAction(SKAction.repeatActionForever(bottomSequence))
    }
    
    private func stopAnimatingWings() {
        self.childNodeWithName("leftWing")?.removeAllActions()
        self.childNodeWithName("rightWing")?.removeAllActions()
    }
    
    private func startSwinging() {
        let firstAction = SKAction.rotateByAngle(0.25, duration: 0.25)
        
        let leftRotation = SKAction.rotateByAngle(-0.5, duration: 0.5)
        let leftMove = SKAction.moveByX(self.mode.body.size.width / 2, y: 0, duration: 0.5)
        let toTheLeft = SKAction.group([leftRotation, leftMove])
        
        let rightRotation = SKAction.rotateByAngle(0.5, duration: 0.5)
        let rightMove = SKAction.moveByX(-self.mode.body.size.width / 2, y: 0, duration: 0.5)
        let toTheRight = SKAction.group([rightRotation, rightMove])
        
        let sequence = SKAction.repeatActionForever(SKAction.sequence([toTheLeft, toTheRight]))
        sequence.timingMode = SKActionTimingMode.EaseIn
        self.runAction(SKAction.sequence([firstAction, sequence]))
    }
    
    private func stopSwinging() {
        
    }
    
    func setupSprites() {
        self.removeAllChildren()
        self.addChild(mode.body)
        self.addChild(mode.leftWing)
        self.addChild(mode.righWing)
    }
        
}
