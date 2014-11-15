//
//  GameSceneBuild.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    
    func setupCables() {
        cable1.position = CGPointMake(self.size.width / 2 + 50, 300);
        cable2.position = CGPointMake(self.size.width / 2, 200);
        cable3.position = CGPointMake(self.size.width / 2, 120);
        cable4.position = CGPointMake(self.size.width / 2, 50);
        
        if let size = cable1.texture?.size() {
            cable1.physicsBody = SKPhysicsBody(texture: cable1.texture, size: size)
        }
        cable1.physicsBody?.dynamic = false
        
        let cable2texture = SKTexture(imageNamed: "cable2")
        cable2.physicsBody = SKPhysicsBody(texture: cable2texture, size: cable2texture.size())
        cable2.physicsBody?.dynamic = false
        
        let cable3texture = SKTexture(imageNamed: "cable3")
        cable3.physicsBody = SKPhysicsBody(texture: cable3texture, size: cable3texture.size())
        cable3.physicsBody?.dynamic = false
        
        let cable4texture = SKTexture(imageNamed: "cable4")
        cable4.physicsBody = SKPhysicsBody(texture: cable4texture, size: cable4texture.size())
        cable4.physicsBody?.dynamic = false
        
        self.addChild(cable1)
        self.addChild(cable2)
        self.addChild(cable3)
        self.addChild(cable4)
    }
    
    func buildInitialScene() {
        for idx in stride(from: 100, through: 1000, by: 150) {
            let sittingBird = FlyingBirdNode.bird(mode: .Sitting, position: CGPoint(x:idx, y:700));
            if let body = self.physicsWorld.bodyAlongRayStart(sittingBird.position, end: CGPoint(x:sittingBird.position.x, y:0)) {
                if let node = body.node {
                    let size = node.calculateAccumulatedFrame()
                    sittingBird.position = CGPoint(x:sittingBird.position.x, y:node.position.y + (size.height /* * node.yScale */ * 0.5));
                }
            }
            self.addChild(sittingBird)
        }
    }
}
