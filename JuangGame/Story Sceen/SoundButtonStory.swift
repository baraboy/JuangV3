//
//  SoundButtonStory.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 10/11/23.
//

import Foundation
import SpriteKit

class SoundButtonStory: SKSpriteNode {
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")

    var screenIdentifier: String

        init(screenIdentifier: String) {
            self.screenIdentifier = screenIdentifier

            let texture = UserDefaults.standard.bool(forKey: "SoundActive") ? soundOnTexture : soundOffTexture
            super.init(texture: texture, color: .clear, size: texture.size())
            self.isUserInteractionEnabled = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let isActive = UserDefaults.standard.bool(forKey: "SoundActive")
        self.texture = isActive ? soundOffTexture : soundOnTexture
        UserDefaults.standard.set(!isActive, forKey: "SoundActive")

        if isActive {
            SoundManager.shared.stopBackgroundMusic()
            switch screenIdentifier {
                case "StorySatu":
                    SoundManager.shared.stopVoiceStory1()
                case "StoryDua":
                    SoundManager.shared.stopVoiceStory2()
                case "StoryTiga":
//                    SoundManager.shared.stopVoiceStory3_1()
//                    SoundManager.shared.stopVoiceStory3_2()
                    SoundManager.shared.stopVoiceStory3()
                case "StoryEmpat":
                    SoundManager.shared.stopVoiceStory4()
                case "StoryLima":
                    SoundManager.shared.stopVoiceStory5()
                case "StoryEnam":
                    SoundManager.shared.stopVoiceStory6()
                default:
                    break
                }
        } else {
            SoundManager.shared.playBackgroundMusic()
            
            switch screenIdentifier {
                case "StorySatu":
                    SoundManager.shared.playVoiceStory1(withDelay: 0.4)
                case "StoryDua":
                    SoundManager.shared.playVoiceStory2()
                case "StoryTiga":
//                    SoundManager.shared.playVoiceStory3_1 {
//                        SoundManager.shared.playVoiceStory3_2(withDelay: 3.0)
//                    }
                    SoundManager.shared.playVoiceStory3()
                case "StoryEmpat":
                    SoundManager.shared.playVoiceStory4()
                case "StoryLima":
                    SoundManager.shared.playVoiceStory5()
                case "StoryEnam":
                    SoundManager.shared.playVoiceStory6()
                default:
                    break
                }
        }
    }
}

