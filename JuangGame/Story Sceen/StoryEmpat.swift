//
//  StoryEmpat.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import Foundation
import SpriteKit

class StoryEmpat: SKScene {
    
    private var initialTouch: CGPoint = CGPoint.zero
    private var background: SKSpriteNode?
    //private var soundButton: SoundButtonStory?
    var soundButton = SoundButtonStory(screenIdentifier: "StoryEmpat")
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")
    
    override func didMove(to view: SKView) {
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        SoundManager.shared.stopVoiceStory3()
        
        background = childNode(withName: "background") as? SKSpriteNode
        background?.size = self.size
        
        soundButton = SoundButtonStory(screenIdentifier: "StoryEmpat")
        soundButton.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        soundButton.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        addChild(soundButton)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playBackgroundMusic()
            SoundManager.shared.playVoiceStory4()
        }
        
        if UserDefaults.standard.bool(forKey: "isHaveReadStory") {
            addSkipLabel()
        }
        addAnimatedLabel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "skipLabel" {
                    if let scene = SKScene(fileNamed: "StoryEnam") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endTouch = touch.location(in: self.view)
            
            // Jika sentuhan berakhir di bagian kiri layar
            if endTouch.x < self.size.width / 3 {
                if let scene = SKScene(fileNamed: "StoryTiga") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
            // Jika sentuhan berakhir di bagian kanan layar
            else if endTouch.x > 2 * self.size.width / 3 {
                // Navigasi ke scene selanjutnya
                if let scene = SKScene(fileNamed: "StoryLima") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
        }
    }
    
    private func addAnimatedLabel() {
        let newText = "Namun, pihak Jepang menolak keras untuk memberikan senjata tersebut."
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.09, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 348, finishTypingOnTouch: true)
        label.position.x += -153
        label.position.y += 110
        label.zPosition = 4
        addChild(label)
        let actions: SKAction = .run { label.update(text: newText) }
        label.run(actions)
    }
    
    private func addSkipLabel() {
        let skipLabelTexture = SKTexture(imageNamed: "skipButton")
        let skipLabel = SKSpriteNode(texture: skipLabelTexture)
        skipLabel.size = CGSize(width: size.width * 0.08215962, height: size.height * 0.07633588)
        skipLabel.position = CGPoint(x: size.width * 0.43075117, y: size.height * 0.41475827)
        skipLabel.zPosition = 5
        skipLabel.name = "skipLabel"
        addChild(skipLabel)
    }
}
