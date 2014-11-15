//
//  FlyingBirdNode.swift
//  ChorusBirdie
//
//  Created by Konrad Szczesniak on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit


class FlyingBirdNode : SKSpriteNode {
    
    enum ModeEnum {
        case Flying, Sitting
        
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
        
        private var leftWingAnchorPoint:CGPoint {
            switch (self) {
            case .Flying:
                return CGPointMake(0, 0)
            case .Sitting:
                return CGPointMake(1, 1)
            }
        }
        
        private var rightWingAnchorPoint:CGPoint {
            switch (self) {
            case .Flying:
                return CGPointMake(1, 1)
            case .Sitting:
                return CGPointMake(1, 0)
            }
        }
        
        private var bodyImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-body"
            case .Sitting:
                return "sitting-bird-body"
            }
        }
        
        private var leftWingImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-wing-left"
            case .Sitting:
                return "sitting-bird-wing-left"
            }
        }

        private var rightWingImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-wing-right"
            case .Sitting:
                return "sitting-bird-wing-right"
            }
        }

    }
    
    var mode:ModeEnum = .Flying {
        didSet {
            self.texture = SKTexture(imageNamed: mode.bodyImageName)
            if let size = self.texture?.size() {
                self.size = size
            }
            
            self.setupWings()
            
            if mode == .Sitting {
                self.childNodeWithName("leftWing")?.zRotation = CGFloat(M_PI) / 2
                self.childNodeWithName("rightWing")?.zRotation = CGFloat(M_PI) / 2
            } else {
                self.childNodeWithName("leftWing")?.zRotation = 0
                self.childNodeWithName("rightWing")?.zRotation = 0
            }
            
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
        
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: node.texture, size: node.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
            node.physicsBody?.allowsRotation = false
        }
        
        return node
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
   
    override init() {
        super.init()
        
        self.color = UIColor.whiteColor()
        self.texture = SKTexture(imageNamed: mode.bodyImageName)
        if let size = self.texture?.size() {
            self.size = size
        }
        self.setupWings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupWings() {
        self.removeAllChildren()
        self.addChild(mode.leftWing)
        self.addChild(mode.righWing)
    }
    
}
