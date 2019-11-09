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
    case flying, landing, sitting

    var leftWing: SKSpriteNode {
      let node = SKSpriteNode(texture: SKTexture(imageNamed: leftWingImageName))
      node.name = "leftWing"
      node.anchorPoint = self.leftWingAnchorPoint
      return node
    }

    var righWing: SKSpriteNode {
      let node = SKSpriteNode(texture: SKTexture(imageNamed: rightWingImageName))
      node.name = "rightWing"
      node.anchorPoint = self.rightWingAnchorPoint
      return node
    }

    var body: SKSpriteNode {
      let node = SKSpriteNode(texture: SKTexture(imageNamed: bodyImageName))
      node.name = "body"
      node.color = .white
      if let size = node.texture?.size() {
        node.size = size
      }
//                node.anchorPoint = CGPoint(x: 0.5, y: 0.0);

      return node
    }

    private var leftWingAnchorPoint: CGPoint {
      switch self {
        case .flying:
          return CGPoint(x: 0, y: 0)
        case .landing, .sitting:
          return CGPoint(x: 1, y: 1)
      }
    }

    private var rightWingAnchorPoint: CGPoint {
      switch self {
        case .flying:
          return CGPoint(x: 1, y: 1)
        case .landing, .sitting:
          return CGPoint(x: 1, y: 0)
      }
    }

    private var bodyImageName: String {
      switch self {
        case .flying:
          return "flying-bird-body"
        case .landing, .sitting:
          return "sitting-bird-body"
      }
    }

    private var leftWingImageName: String {
      switch self {
        case .flying:
          return "flying-bird-wing-left"
        case .landing, .sitting:
          return "sitting-bird-wing-left"
      }
    }

    private var rightWingImageName: String {
      switch self {
        case .flying:
          return "flying-bird-wing-right"
        case .landing, .sitting:
          return "sitting-bird-wing-right"
      }
    }
  }
}
