//
//  FlyingBirdNode.swift
//  ChorusBirdie
//
//  Created by Konrad Szczesniak on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit


class FlyingBirdNode : SKEffectNode {

    var mode:ModeEnum = .Flying {
        didSet {
            self.setupSprites()
            
            switch (mode) {
            case .Landing, .Sitting:
                self.childNodeWithName("leftWing")?.zRotation = CGFloat(M_PI) / 2
                self.childNodeWithName("rightWing")?.zRotation = CGFloat(M_PI) / 2
                break;
            case .Flying:
                self.childNodeWithName("leftWing")?.zRotation = 0
                self.childNodeWithName("rightWing")?.zRotation = 0
                break;
            }
            
            self.shouldEnableEffects = mode == .Sitting
            
            if animated {
                self.startAnimatingWings()
            }
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
    
    class func bird(mode: ModeEnum = .Flying, animated:Bool = true, position: CGPoint = CGPoint(x:100,y:700)) -> FlyingBirdNode {
        let node = FlyingBirdNode()
        node.position = position
        node.mode    = mode
        node.animated = animated
        let bodyNode = node.mode.body
        
        if let texture = bodyNode.texture {
            node.physicsBody = SKPhysicsBody(texture: bodyNode.texture, size: bodyNode.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
            node.physicsBody?.allowsRotation = false
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
            durationLeft = 0.05 + CGFloat(arc4random_uniform(10)) / 100.0
            durationRight = 0.05 + CGFloat(arc4random_uniform(10)) / 100.0
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
    
    func setupSprites() {
        self.removeAllChildren()
        self.addChild(mode.body)
        self.addChild(mode.leftWing)
        self.addChild(mode.righWing)
    }
    
}
