//
//  GameViewController.swift
//  ChorusBirdie
//
//  Created by Dariusz Rybicki on 15/11/14.
//  Copyright (c) 2014 SwiftCrunch. All rights reserved.
//

import SpriteKit
import UIKit

extension SKNode {
  class func unarchiveFromFile(file: String) -> SKNode? {
    if let url = Bundle.main.url(forResource: file, withExtension: "sks") {
      let sceneData = try! Data(contentsOf: url)
      let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)

      archiver.setClass(classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
}

class GameViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    if let scene = GameScene.unarchiveFromFile(file: "GameScene") as? GameScene {
      // Configure the view.
      let skView = view as! SKView
      skView.showsFPS = false
      skView.showsNodeCount = false

      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true

      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .aspectFill

      skView.presentScene(scene)
    }
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
}
