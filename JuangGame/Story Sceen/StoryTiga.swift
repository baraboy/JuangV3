//
//  StoryTiga.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import Foundation
import SpriteKit

class StoryTiga: SKScene {
    
    private var initialTouch: CGPoint = CGPoint.zero
    private var background: SKSpriteNode?
    private var backgroundtanah: SKSpriteNode?
    //private var soundButton: SoundButtonStory?
    var soundButton = SoundButtonStory(screenIdentifier: "StoryTiga")
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")
    
    override func didMove(to view: SKView) {
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        
        background = childNode(withName: "background") as? SKSpriteNode
        background?.size = self.size
        
        backgroundtanah = childNode(withName: "backgroundtanah") as? SKSpriteNode
        backgroundtanah?.size = CGSize(width: self.size.width, height: (backgroundtanah?.size.height)!)
        
        soundButton = SoundButtonStory(screenIdentifier: "StoryTiga")
        soundButton.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        soundButton.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        addChild(soundButton)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playBackgroundMusic()
            SoundManager.shared.playVoiceStory3_1 {
                SoundManager.shared.playVoiceStory3_2(withDelay: 3.0)
            }
        }
        
        if UserDefaults.standard.bool(forKey: "isHaveReadStory") {
            addSkipLabel()
        }
        
        addAnimatedLabel()

        let delay = SKAction.wait(forDuration: 9.5)
        let addSecondLabel = SKAction.run(addSecondAnimatedLabel)
        let sequence = SKAction.sequence([delay, addSecondLabel])
        run(sequence)
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
                if let scene = SKScene(fileNamed: "StoryDua") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
            // Jika sentuhan berakhir di bagian kanan layar
            else if endTouch.x > 2 * self.size.width / 3 {
                // Navigasi ke scene selanjutnya
                if let scene = SKScene(fileNamed: "StoryEmpat") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
        }
    }
    
    private func addAnimatedLabel() {
//        let newText = "Rakyat menyadari mereka membutuhkan lebih banyak senjata untuk mempertahankan kemerdekaan."
//        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.1, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 428, finishTypingOnTouch: true)
//        label.position.x += -50
//        label.position.y -= 102
//        label.zPosition = 4
//        addChild(label)
//        let actions: SKAction = .run { label.update(text: newText) }
//        label.run(actions)
        let rectangle = SKSpriteNode(imageNamed: "textBoxStory3")
        rectangle.position = CGPoint(x: size.width * 0.15661972, y: -size.height * 0.27519338)
        rectangle.size = CGSize(width: 455, height: 85)
        rectangle.zPosition = 10
        addChild(rectangle)
        
        let newText = "Rakyat menyadari mereka membutuhkan lebih banyak senjata untuk mempertahankan kemerdekaan."
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.08, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 428, finishTypingOnTouch: true)
        label.position = CGPoint(x: -205, y: 5)
        label.zPosition = 11
        rectangle.addChild(label)
        
        let actions: SKAction = .run { label.update(text: newText) }
        label.run(actions)
        
        let removeLabel = SKAction.run { [weak self] in
            label.removeFromParent()
        }
        let delay = SKAction.wait(forDuration: 9.0)
        let sequence = SKAction.sequence([delay, removeLabel])
        run(sequence)
        
    }
    
    private func addSecondAnimatedLabel() {
//        let newText = "Rakyat pun meminta senjata bekas PETA kepada Jepang."
//        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.1, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 435, finishTypingOnTouch: true)
//        label.position.x += -50
//        label.position.y -= 100
//        label.zPosition = 4
//        addChild(label)
//        let actions: SKAction = .run { label.update(text: newText) }
//        label.run(actions)
        
        let rectangle = SKSpriteNode(imageNamed: "textBoxStory3")
        rectangle.position = CGPoint(x: size.width * 0.15661972, y: -size.height * 0.27519338)
        rectangle.size = CGSize(width: 455, height: 85)
        rectangle.zPosition = 10
        addChild(rectangle)
        
        let newText = "Rakyat pun meminta senjata bekas PETA kepada Jepang."
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.09, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 435, finishTypingOnTouch: true)
        label.position = CGPoint(x: -205, y: 5)
        label.zPosition = 11
        rectangle.addChild(label)
        
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
