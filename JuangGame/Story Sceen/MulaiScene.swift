//
//  MulaiScene.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 27/10/23.
//

import SpriteKit
import AVFoundation

class MulaiScene: SKScene {
    
    private var btn_Mulai: SKSpriteNode?
    var backgroundMusic: AVAudioPlayer?
    private var background: SKSpriteNode?
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")

    
    override func didMove(to view: SKView) {
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        
        background = childNode(withName: "background") as? SKSpriteNode
        background?.size = self.size
        
        btn_Mulai = childNode(withName: "btn_Mulai") as? SKSpriteNode
        btn_Mulai?.name = "btn_Mulai"
        btn_Mulai?.position = CGPoint(x: 20, y: -36)
        btn_Mulai?.size = CGSize(width: size.width * 0.3028169, height: size.height * 0.17302799)
        
        
        sound = childNode(withName: "sound") as? SKSpriteNode
        sound?.name = "sound"
        sound?.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        sound?.size =  CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        
        //userdefaults music
        UserDefaults.standard.register(defaults: ["SoundActive": true])
        SoundManager.shared.playMulaiSceneSound()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "sound" {
                    if UserDefaults.standard.bool(forKey: "SoundActive") {
                        sound?.texture = soundOffTexture
                        UserDefaults.standard.set(false, forKey: "SoundActive")
                        SoundManager.shared.stopMulaiSceneSound()
                    } else {
                        sound?.texture = soundOnTexture
                        UserDefaults.standard.set(true, forKey: "SoundActive")
                        SoundManager.shared.playMulaiSceneSound()
                    }
                }

                
                if node.name == "btn_Mulai" {
                    SoundManager.shared.stopMulaiSceneSound()
                    if let scene = SKScene(fileNamed: "StorySatu") {
                        
                        let transition = SKTransition.fade(withDuration: 1)
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene, transition: transition)
                    }
                }
            }
            
        }
    }
}
