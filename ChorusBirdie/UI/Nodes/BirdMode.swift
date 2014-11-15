//
//  BirdMode.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import Foundation
import SpriteKit

extension FlyingBirdNode {
    
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
//                node.anchorPoint = CGPoint(x: 0.5, y: 0.0);
                
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
}