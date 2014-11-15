//
//  SittingBirdNode.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit

class SittingBirdNode : SKSpriteNode {
    class func bird() -> SittingBirdNode {
        let node = SittingBirdNode()
        
        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(texture: node.texture, size: node.size)
            node.physicsBody?.dynamic = true
            node.physicsBody?.mass = 0.1
        }
        
        return node
    }
    
    override init() {
        let birdTexture = SKTexture(imageNamed: "sitiing-bird")
        super.init(texture: birdTexture, color: UIColor.whiteColor(), size: birdTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
