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
    
    enum ModeEnum {
        case Flying, Landing, Sitting
        
        var leftWing:SKSpriteNode {
            get {
                let node = SKSpriteNode(texture: SKTexture(imageNamed: leftWingImageName))
                node.name = "leftWing"
                node.anchorPoint = leftWingAnchorPoint
                return node
            }
        }
        
        var righWing:SKSpriteNode {
            get {
                let node = SKSpriteNode(texture: SKTexture(imageNamed: rightWingImageName))
                node.name = "rightWing"
                node.anchorPoint = rightWingAnchorPoint
                return node
            }
        }
        
        var body:SKSpriteNode {
            get {
                let node = SKSpriteNode(texture: SKTexture(imageNamed: bodyImageName))
                node.name = "body"
                node.color = UIColor.whiteColor()
                if let size = node.texture?.size() {
                    node.size = size
                }
                
                return node
            }
        }
        
        private var leftWingAnchorPoint:CGPoint {
            switch (self) {
            case .Flying:
                return CGPointMake(0, 0)
            case .Landing, .Sitting:
                return CGPointMake(1, 1)
            }
        }
        
        private var rightWingAnchorPoint:CGPoint {
            switch (self) {
            case .Flying:
                return CGPointMake(1, 1)
            case .Landing, .Sitting:
                return CGPointMake(1, 0)
            }
        }
        
        private var bodyImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-body"
            case .Landing, .Sitting:
                return "sitting-bird-body"
            }
        }
        
        private var leftWingImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-wing-left"
            case .Landing, .Sitting:
                return "sitting-bird-wing-left"
            }
        }

        private var rightWingImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-wing-right"
            case .Landing, .Sitting:
                return "sitting-bird-wing-right"
            }
        }

    }
    
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
