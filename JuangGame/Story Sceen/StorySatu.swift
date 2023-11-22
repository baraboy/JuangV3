//
//  StorySatu.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import Foundation
import SpriteKit

class StorySatu: SKScene {
    
    private var initialTouch: CGPoint = CGPoint.zero
    private var background: SKSpriteNode?
    //private var soundButton: SoundButtonStory?
    var soundButton = SoundButtonStory(screenIdentifier: "StorySatu")
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")
    
    override func didMove(to view: SKView) {
        
       //addAnimatedLabel()
        background = childNode(withName: "background") as? SKSpriteNode
        //background?.size = self.size
        
        let rectangle = SKSpriteNode(imageNamed: "textBoxStory1")
        rectangle.position = CGPoint(x: -size.width * 0.27, y: size.height * 0)
        rectangle.size = CGSize(width: 285, height: 105)
        rectangle.zPosition = 10
        addChild(rectangle)
        
        let newText = "Bom atom dijatuhkan di Hiroshima dan Nagasaki menandakan awal kekalahan Jepang."
        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.08, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 260, finishTypingOnTouch: true)
        label.position = CGPoint(x: -132, y: 20)
        label.zPosition = 11
        rectangle.addChild(label)
        
        let actions: SKAction = .run { label.update(text: newText) }
        label.run(actions)
        
        
        
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        SoundManager.shared.stopVoiceStory3()
        
        soundButton = SoundButtonStory(screenIdentifier: "StorySatu")
        soundButton.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        soundButton.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        addChild(soundButton)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playBackgroundMusic()
            SoundManager.shared.playVoiceStory1(withDelay: 0.4)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endTouch = touch.location(in: self.view)
            
             //Jika sentuhan berakhir di bagian kanan layar
            if endTouch.x > 2 * self.size.width / 3 {
                // Navigasi ke scene selanjutnya
                if let scene = SKScene(fileNamed: "StoryDua") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view?.presentScene(scene)
                }
            }
            
        }
    }
//    private func addAnimatedLabel() {
//        let newText = "Bom atom dijatuhkan di Hiroshima dan Nagasaki menandakan awal kekalahan Jepang."
//        let label = MSKAnimatedLabel(text: newText, horizontalAlignment: .left, durationPerCharacter: 0.1, fontSize: 17, marginVertical: 25.0, fontColor: .black, fontName: "SF Pro Rounded Semibold", labelWidth: 260, finishTypingOnTouch: true)
//        label.position = CGPoint(x: -133, y: 20)
//        label.zPosition = 11
//        addChild(label)
//        let actions: SKAction = .run { label.update(text: newText) }
//        label.run(actions)
//    }
}
