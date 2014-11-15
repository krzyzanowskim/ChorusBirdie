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
                node.anchorPoint = CGPointMake(0, 0)
                return node
            }
        }
        
        var righWing:SKSpriteNode {
            get {
                let node = SKSpriteNode(texture: SKTexture(imageNamed: rightWingImageName))
                node.anchorPoint = CGPointMake(1, 1)
                return node
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
                return "flying-bird-wing-up"
            case .Sitting:
                return "sitting-bird-wing-up"
            }
        }

        private var rightWingImageName:String {
            switch (self) {
            case .Flying:
                return "flying-bird-wing-down"
            case .Sitting:
                return "sitting-bird-wing-down"
            }
        }

    }
    
    var mode:ModeEnum = .Flying {
        didSet {
            self.texture = SKTexture(imageNamed: mode.bodyImageName)
        }
    }
    
    var leftWing: SKSpriteNode
    var rightWing: SKSpriteNode
    
    class func bird(position: CGPoint = CGPoint(x:400,y:400)) -> FlyingBirdNode {
        let node = FlyingBirdNode()
        node.position = position
        
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: node.texture, size: node.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
        }
        
        return node
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        leftWing = mode.leftWing
        rightWing = mode.righWing
        super.init(texture: texture, color: color, size: size)
    }
   
    override init() {
        leftWing = mode.leftWing
        rightWing = mode.righWing
        
        super.init()
        
        self.color = UIColor.whiteColor()
        self.texture = SKTexture(imageNamed: "flying-bird-body")
        if let size = self.texture?.size() {
            self.size = size
        }
        self.addChild(leftWing)
        self.addChild(rightWing)
    }

    required init?(coder aDecoder: NSCoder) {
        leftWing = mode.leftWing
        rightWing = mode.righWing
        super.init(coder: aDecoder)
    }
    
    func startAnimatingWings() {
        let toTheRight = SKAction.rotateByAngle(0.5, duration: 0.2)
        let toTheLeft = SKAction.rotateByAngle(-0.5, duration: 0.2)
        let topSequence = SKAction.sequence([toTheRight, toTheLeft])
        let bottomSequence = SKAction.sequence([toTheLeft, toTheRight])
        
        
        leftWing.runAction(SKAction.repeatActionForever(topSequence))
        rightWing.runAction(SKAction.repeatActionForever(bottomSequence))
    }
    
    func stopAnimatingWings() {
        leftWing.removeAllActions()
        rightWing.removeAllActions()
    }
    
}
