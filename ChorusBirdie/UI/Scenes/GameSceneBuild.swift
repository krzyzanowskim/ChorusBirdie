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
    func buildInitialScene() {
        
        for _ in 1...1 {
            let sittingBird = FlyingBirdNode.bird(mode: .Sitting);
            self.addChild(sittingBird)
            let joint = SKPhysicsJointSpring.jointWithBodyA(sittingBird.physicsBody, bodyB: cable1.physicsBody, anchorA: CGPoint(x:0, y:0), anchorB: CGPoint(x:0, y:0))
            //let joint = SKPhysicsJointFixed.jointWithBodyA(sittingBird.physicsBody, bodyB: cable1.physicsBody, anchor: CGPoint(x:sittingBird.position.x,y:sittingBird.position.y))
//            self.physicsWorld.addJoint(joint)
            if let scene = self.scene {
                scene.physicsWorld.addJoint(joint)
            }
        }
        
    }
}
