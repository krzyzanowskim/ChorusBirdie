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
    
    var animated:Bool = false {
        didSet {
            if animated {
                self.startAnimatingWings()
            } else {
                self.stopAnimatingWings()
            }
        }
    }
    
    private func startAnimatingWings() {
        let toTheRight = SKAction.rotateByAngle(0.5, duration: 0.2)
        let toTheLeft = SKAction.rotateByAngle(-0.5, duration: 0.2)
        let topSequence = SKAction.sequence([toTheRight, toTheLeft])
        let bottomSequence = SKAction.sequence([toTheLeft, toTheRight])
        
        self.childNodeWithName("leftWing")?.runAction(SKAction.repeatActionForever(topSequence))
        self.childNodeWithName("rightWing")?.runAction(SKAction.repeatActionForever(bottomSequence))
    }
    
    private func stopAnimatingWings() {
        self.childNodeWithName("leftWing")?.removeAllActions()
        self.childNodeWithName("rightWing")?.removeAllActions()
    }
    
    class func bird(position: CGPoint = CGPoint(x:400,y:400)) -> FlyingBirdNode {
        let node = FlyingBirdNode()
        node.position = position
        let bodyNode = node.mode.body

        if let texture = bodyNode.texture {
            node.physicsBody = SKPhysicsBody(texture: bodyNode.texture, size: bodyNode.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
            node.physicsBody?.allowsRotation = false
        }
        return node
    }
    
    var greyFilter:CIFilter {
        return CIFilter(name: "CIColorControls", withInputParameters: ["inputBrightness": 0.0, "inputSaturation":0.0])
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
    
    
    func setupSprites() {
        self.removeAllChildren()
        self.addChild(mode.body)
        self.addChild(mode.leftWing)
        self.addChild(mode.righWing)
    }
    
}
