//
//  StoryEnam.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import AVFoundation
import SpriteKit

class StoryEnam: SKScene {
    
    private var nextButton: SKSpriteNode?
    private var initialTouch: CGPoint = CGPoint.zero
    private var background: SKSpriteNode?
    //private var soundButton: SoundButtonStory?
    var soundButton = SoundButtonStory(screenIdentifier: "StoryEnam")
    
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
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory1()
        
        soundButton = SoundButtonStory(screenIdentifier: "StoryEnam")
        soundButton.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        soundButton.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        addChild(soundButton)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playBackgroundMusic()
            SoundManager.shared.playVoiceStory6()
        }
        
        background = childNode(withName: "background") as? SKSpriteNode
        background?.size = self.size
        
        nextButton = childNode(withName: "nextButton") as? SKSpriteNode
        nextButton?.name = "nextButton"
        nextButton?.position = CGPoint(x: size.width * 0.4342723, y: -size.height * 0.37022901)
        nextButton?.size = CGSize(width: size.width * 0.07981221, height: size.height * 0.17302799)
        
        //addAnimatedLabel()
        
        let rectangle = SKSpriteNode(imageNamed: "textBoxStory5")
        rectangle.position = CGPoint(x: size.width * 0.18634624, y: size.height * 0.18128499)
        rectangle.size = CGSize(width: 405, height: 55)
        rectangle.zPosition = 10
        addChild(rectangle)
        
        let newText = "Mampukah mereka melakukan rencana tersebut?"
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.09, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 380, finishTypingOnTouch: true)
        label.position = CGPoint(x: -190, y: -7)
        label.zPosition = 11
        rectangle.addChild(label)
        
        let actions: SKAction = .run { label.update(text: newText) }
        label.run(actions)
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isHaveReadStory")

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "nextButton" {
                    if let scene = SKScene(fileNamed: "CardPerStageScene") {
                        print("Berhasil menekan")
                        // Set the scale mode to scale to fit the window
                        let transition = SKTransition.fade(withDuration: 1)
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene, transition: transition)
                    }
                }
            }
        }
        if let touch = touches.first {
            initialTouch = touch.location(in: self.view)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endTouch = touch.location(in: self.view)
            
            // Jika sentuhan berakhir di bagian kiri layar
            if endTouch.x < self.size.width / 3 {
                if let scene = SKScene(fileNamed: "StoryLima") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
        }
    }
    
//    private func addAnimatedLabel() {
//        let newText = "Mampukah mereka melakukan rencana tersebut?"
//        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.1, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 380, finishTypingOnTouch: true)
//        label.position.x += 14
//        label.position.y += 65
//        label.zPosition = 4
//        addChild(label)
//        let actions: SKAction = .run { label.update(text: newText) }
//        label.run(actions)
//    }
}
