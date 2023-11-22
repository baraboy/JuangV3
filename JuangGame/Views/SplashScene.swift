//
//  SplashScene.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 12/11/23.
//

import SpriteKit

class SplashScene: SKScene {
  override func didMove(to view: SKView) {
      SoundManager.shared.stopCardPerSceneSound()
      SoundManager.shared.stopSpyMusic()
      SoundManager.shared.stopBackgroundMusic()
      SoundManager.shared.stopMulaiSceneSound()
      SoundManager.shared.stopGameMusic()
      
      let splash = childNode(withName: "backgroundImage") as? SKSpriteNode
      splash?.size = self.size
      let wait = SKAction.wait(forDuration: 3.0)
      let transition = SKAction.run {
          let mulaiScene = MulaiScene(fileNamed: "MulaiScene")
          mulaiScene?.scaleMode = .resizeFill
          view.presentScene(mulaiScene)
      }
      splash?.run(SKAction.sequence([wait, transition]))
  }
}





