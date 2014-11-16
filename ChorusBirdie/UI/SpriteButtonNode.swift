//
//  File.swift
//  ChorusBirdie
//
//  Created by Marcin Krzyzanowski on 16/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import UIKit
import SpriteKit

class SpriteButtonNode : SKLabelNode {
    
    var onPressed:(() -> ())?

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let onPressed = onPressed {
            onPressed()
        }
    }
}
