//
//  File.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit
import UIKit

class SpriteButtonNode: SKLabelNode {
  var onPressed: (() -> Void)?

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    if let onPressed = onPressed {
      onPressed()
    }
  }
}
