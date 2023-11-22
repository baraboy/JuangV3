//
//  SoundManager.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/11/23.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    var backgroundMusic: AVAudioPlayer?
    var mulaiSceneMusic: AVAudioPlayer?
    var cardPerStageMusic: AVAudioPlayer?
    var alarmSound: AVAudioPlayer?
    var gameMusic: AVAudioPlayer?
    var spyMusic: AVAudioPlayer?
    var voiceStory1: AVAudioPlayer?
    var voiceStory2: AVAudioPlayer?
    var voiceStory3_1: AVAudioPlayer?
    var voiceStory3_2: AVAudioPlayer?
    var voiceStory4: AVAudioPlayer?
    var voiceStory5: AVAudioPlayer?
    var voiceStory6: AVAudioPlayer?
    var voiceStory3: AVAudioPlayer?
    
    private init () {
        if let soundURL = Bundle.main.url(forResource: "storySound", withExtension: "mp3") {
            do {
                backgroundMusic = try AVAudioPlayer(contentsOf: soundURL)
                backgroundMusic?.numberOfLoops = -1
                backgroundMusic?.volume = 0.0
                
                let duration = 1.0
                let interval = 0.5
                
                Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                    let progress = timer.timeInterval / duration
                    if progress >= 1.0 {
                        timer.invalidate()
                        self.backgroundMusic?.volume = 1.0
                    } else {
                        self.backgroundMusic?.volume = 0.1 /*Float(progress)*/ //Atur volume 
                    }
                }
                
                backgroundMusic?.prepareToPlay()
                //backgroundMusic?.play()
            } catch {
                print("Error to play")
            }
        }
        
        if let soundAwalScene = Bundle.main.url(forResource: "mulaiSound", withExtension: "wav") {
            do {
                mulaiSceneMusic = try AVAudioPlayer(contentsOf: soundAwalScene)
                //mulaiSceneMusic?.numberOfLoops = -1                
                mulaiSceneMusic?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let soundAwalScene = Bundle.main.url(forResource: "cardPerStageMusic", withExtension: "mp3") {
            do {
                cardPerStageMusic = try AVAudioPlayer(contentsOf: soundAwalScene)
                cardPerStageMusic?.numberOfLoops = -1
                cardPerStageMusic?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let alarmSoundStage2 = Bundle.main.url(forResource: "alarmSound", withExtension: "wav") {
            do {
                alarmSound = try AVAudioPlayer(contentsOf: alarmSoundStage2)
                //mulaiSceneMusic?.numberOfLoops = -1
                alarmSound?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let gameSoundStage = Bundle.main.url(forResource: "Warsong", withExtension: "mp3") {
            do {
                gameMusic = try AVAudioPlayer(contentsOf: gameSoundStage)
                //mulaiSceneMusic?.numberOfLoops = -1
                gameMusic?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let gameSoundStage = Bundle.main.url(forResource: "spySong", withExtension: "wav") {
            do {
                spyMusic = try AVAudioPlayer(contentsOf: gameSoundStage)
                spyMusic?.numberOfLoops = -1
                spyMusic?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory1 = Bundle.main.url(forResource: "Story 1", withExtension: "wav") {
            do {
                voiceStory1 = try AVAudioPlayer(contentsOf: voiceOverStory1)
                voiceStory1?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory2 = Bundle.main.url(forResource: "Story 2", withExtension: "wav") {
            do {
                voiceStory2 = try AVAudioPlayer(contentsOf: voiceOverStory2)
                voiceStory2?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory3_1 = Bundle.main.url(forResource: "Story 3 - 1", withExtension: "wav") {
            do {
                voiceStory3_1 = try AVAudioPlayer(contentsOf: voiceOverStory3_1)
                voiceStory3_1?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory3_2 = Bundle.main.url(forResource: "Story 3 - 2", withExtension: "wav") {
            do {
                voiceStory3_2 = try AVAudioPlayer(contentsOf: voiceOverStory3_2)
                voiceStory3_2?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory4 = Bundle.main.url(forResource: "Story 4", withExtension: "wav") {
            do {
                voiceStory4 = try AVAudioPlayer(contentsOf: voiceOverStory4)
                voiceStory4?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory5 = Bundle.main.url(forResource: "Story 5", withExtension: "wav") {
            do {
                voiceStory5 = try AVAudioPlayer(contentsOf: voiceOverStory5)
                voiceStory5?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory6 = Bundle.main.url(forResource: "Story 6", withExtension: "wav") {
            do {
                voiceStory6 = try AVAudioPlayer(contentsOf: voiceOverStory6)
                voiceStory6?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }
        
        if let voiceOverStory3 = Bundle.main.url(forResource: "Story 3", withExtension: "wav") {
            do {
                voiceStory3 = try AVAudioPlayer(contentsOf: voiceOverStory3)
                voiceStory3?.prepareToPlay()
            } catch {
                print("Error to play")
            }
        }

    }
    
    func playDelayed(sound: AVAudioPlayer, delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            sound.play()
        }
    }
    
    func setVolume(sound: AVAudioPlayer, volume: Float) {
        sound.play()
        sound.volume = volume
    }
    
    func playBackgroundMusic() {
        backgroundMusic?.play()
    }
    
    func stopBackgroundMusic() {
        backgroundMusic?.stop()
    }
    
    func playMulaiSceneSound() {
        mulaiSceneMusic?.play()
    }
    
    func stopMulaiSceneSound() {
        mulaiSceneMusic?.stop()
    }
    
    func playCardPerSceneSound() {
        cardPerStageMusic?.play()
    }
    
    func stopCardPerSceneSound() {
        cardPerStageMusic?.stop()
    }
    
    func stopAlarmSound() {
        alarmSound?.stop()
    }
    
    func playAlarmSound() {
        alarmSound?.play()
    }
    
    func stopGameMusic() {
        gameMusic?.stop()
    }
    
    func playGameMusic() {
        gameMusic?.play()
    }
    
    func stopSpyMusic() {
        spyMusic?.stop()
    }
    
    func playSpyMusic() {
        spyMusic?.play()
    }
    
    func playVoiceStory1(withDelay delay: TimeInterval = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if let player = self.voiceStory1 {
                player.currentTime = 0
                player.play()
            }
        }
    }
    
    func stopVoiceStory1() {
        voiceStory1?.stop()
    }
    
    func playVoiceStory2() {
    if let player = voiceStory2 {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopVoiceStory2() {
        voiceStory2?.stop()
    }
    
    func playVoiceStory3() {
    if let player = voiceStory3 {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopVoiceStory3() {
        voiceStory3?.stop()
    }
    
    func playVoiceStory3_1(withCompletion completion: @escaping () -> Void) {
            if let player = voiceStory3_1 {
                player.currentTime = 0
                player.play()
                let delay = DispatchTime.now() + Double(player.duration)
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    completion()
                }
            }
        }
    
    func stopVoiceStory3_1() {
        voiceStory3_1?.stop()
    }
    
    func playVoiceStory3_2(withDelay delay: TimeInterval = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if let player = self.voiceStory3_2 {
                player.currentTime = 0
                player.play()
            }
        }
    }
    
    func stopVoiceStory3_2() {
        voiceStory3_2?.stop()
    }
    
    func playVoiceStory4() {
    if let player = voiceStory4 {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopVoiceStory4() {
        voiceStory4?.stop()
    }
    
    func playVoiceStory5() {
    if let player = voiceStory5 {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopVoiceStory5() {
        voiceStory5?.stop()
    }
    
    func playVoiceStory6() {
    if let player = voiceStory6 {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopVoiceStory6() {
        voiceStory6?.stop()
    }
    
    func stopAudioWithFadeOut(duration: TimeInterval) {
        guard let music = backgroundMusic else { return }
        
        let initialVolume = music.volume
        let step = initialVolume / (Float(duration) * 60.0)
        
        Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) {timer in
            music.volume -= Float(step)
            
            if music.volume <= 0.0 {
                timer.invalidate()
                music.stop()
            }
        }
    }
}
