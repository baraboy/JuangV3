//
//  StoryLima.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import Foundation
import SpriteKit

class StoryLima: SKScene {
    
    private var initialTouch: CGPoint = CGPoint.zero
    private var background: SKSpriteNode?
    //private var soundButton: SoundButtonStory?
    var soundButton = SoundButtonStory(screenIdentifier: "StoryLima")
    private var amri: SKSpriteNode?
    private var amka: SKSpriteNode?
    private var barban: SKSpriteNode?
    private var barhiz: SKSpriteNode?
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")
    
    override func didMove(to view: SKView) {
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        SoundManager.shared.stopVoiceStory3()
        
        background = childNode(withName: "background") as? SKSpriteNode
        background?.size = self.size
        
        amri = childNode(withName: "amri") as? SKSpriteNode
        amri?.position = CGPoint(x: -size.width * 0.38732394, y: -size.height * 0.40712468)
        
        amka = childNode(withName: "amka") as? SKSpriteNode
        amka?.position = CGPoint(x: -size.width * 0.12734742, y: -size.height * 0.40712468)
        
        barban = childNode(withName: "barban") as? SKSpriteNode
        barban?.position = CGPoint(x: size.width * 0.11932512, y: -size.height * 0.40712468)
        
        barhiz = childNode(withName: "barhiz") as? SKSpriteNode
        barhiz?.position = CGPoint(x: size.width * 0.37558685, y: -size.height * 0.40712468)
        
        soundButton = SoundButtonStory(screenIdentifier: "StoryLima")
        soundButton.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        soundButton.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        addChild(soundButton)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playBackgroundMusic()
            SoundManager.shared.playVoiceStory5()
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
                if let scene = SKScene(fileNamed: "StoryEmpat") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
            // Jika sentuhan berakhir di bagian kanan layar
            else if endTouch.x > 2 * self.size.width / 3 {
                // Navigasi ke scene selanjutnya
                if let scene = SKScene(fileNamed: "StoryEnam") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
        }
    }
    
    private func addAnimatedLabel() {
        let newText = "Sekumpulan organisasi pemuda di Semarang berencana mencuri senjata tersebut dari Jepang."
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.08, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 381, finishTypingOnTouch: true)
        label.position.x += -185
        label.position.y -= 99
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
