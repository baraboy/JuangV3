//
//  CardStage.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 19/10/23.
//

import SpriteKit

class CardStage: SKScene {

    private var infoCharacter: SKSpriteNode?
    private var infoSejarah: SKSpriteNode?
    private var cardOne = SKSpriteNode()
    let cardOneAtlas = SKTextureAtlas(named: "cardOne")
    var animasiTextures: [SKTexture] = []
    
    private var cardTwo = SKSpriteNode()
    let cardTwoAtlas = SKTextureAtlas(named: "cardTwo")
    var animasiTwoTextures: [SKTexture] = []
    
    private var blockCardTwo: SKSpriteNode?
    private var blockCardThree: SKSpriteNode?
//    private var blockCardTwo = SKSpriteNode()
//    private var blockCardThree = SKSpriteNode()
    private var textCard: SKSpriteNode?
    private var line1: SKSpriteNode?
    private var line2: SKSpriteNode?
    private var line3: SKSpriteNode?
    
    private var sound: SKSpriteNode?
    let soundOnTexture = SKTexture(imageNamed: "soundOn")
    let soundOffTexture = SKTexture(imageNamed: "soundOff")
    
    private var isCardOneAnimating = true
    
    override func didMove(to view: SKView) {
        infoCharacter = childNode(withName: "infoCharacter") as? SKSpriteNode
        infoCharacter?.name = "infoCharacter"
        infoCharacter?.position = CGPoint(x: size.width * 0.43192488, y: size.height * 0.3956743)
        infoCharacter?.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15012733)
        
        infoSejarah = childNode(withName: "infoSejarah") as? SKSpriteNode
        infoSejarah?.name = "infoSejarah"
        infoSejarah?.position = CGPoint(x: size.width * 0.36012559, y: size.height * 0.3956743)
        infoSejarah?.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15012733)
        
        textCard = childNode(withName: "textCard") as? SKSpriteNode
        textCard?.name = "textCard"
        textCard?.zPosition = 10
        textCard?.position = CGPoint(x: size.width * 0, y: size.height * 0.37913486)
        textCard?.size = CGSize(width: size.width * 0.25, height: size.height * 0.07633588)
        
        
        let cardOneTexture = SKTexture(imageNamed: "cardStageOne0")
        let cardOne = SKSpriteNode(texture: cardOneTexture)
        cardOne.name = "cardOne"
        cardOne.position = CGPoint(x: -size.width * 0.37558685, y: size.height * 0)
        cardOne.size = CGSize(width: 161.216, height: 191.397)
        addChild(cardOne)
        
        for i in 0..<cardOneAtlas.textureNames.count {
            let textureName = "cardStageOne\(i)"
            let texture = cardOneAtlas.textureNamed(textureName)
            animasiTextures.append(texture)
        }
        
        let cardTwoTexture = SKTexture(imageNamed: "cardStageTwo0")
        let cardTwo = SKSpriteNode(texture: cardTwoTexture)
        cardTwo.name = "cardTwo"
        cardTwo.position = CGPoint(x: -size.width * 0.11267606, y: -size.height * 0.20468957)
        cardTwo.size = CGSize(width: 161.216, height: 191.397)
        addChild(cardTwo)
        
        for i in 0..<cardTwoAtlas.textureNames.count {
            let textureName = "cardStageTwo\(i)"
            let texture = cardTwoAtlas.textureNamed(textureName)
            animasiTwoTextures.append(texture)
        }
        
//        let blockCardTwoTexture = SKTexture(imageNamed: "cardLock1")
//        let blockCardTwo = SKSpriteNode(texture: blockCardTwoTexture)
//        blockCardTwo.name = "blockCardTwo"
//        blockCardTwo.size = CGSize(width: 120, height: 150)
//        blockCardTwo.zPosition = 50
//        blockCardTwo.position = CGPoint(x: size.width * 0.13360094, y: -size.height * 0.00876081)
//        addChild(blockCardTwo)
//        
//        let blockCardThreeTexture = SKTexture(imageNamed: "cardLock1")
//        let blockCardThree = SKSpriteNode(texture: blockCardThreeTexture)
//        blockCardThree.name = "blockCardThree"
//        blockCardThree.size = CGSize(width: 120, height: 150)
//        blockCardThree.zPosition = 50
//        blockCardThree.position = CGPoint(x: size.width * 0.38125352, y: -size.height * 0.18687786)
//        addChild(blockCardThree)
        
        
        blockCardThree = childNode(withName: "blockCardThree") as? SKSpriteNode
        blockCardThree?.position = CGPoint(x: size.width * 0.38125352, y: -size.height * 0.18687786)
        
        blockCardTwo = childNode(withName: "blockCardTwo") as? SKSpriteNode
        blockCardTwo?.position = CGPoint(x: size.width * 0.13360094, y: -size.height * 0.00876081)
        
        line1 = childNode(withName: "line1") as? SKSpriteNode
        line1?.position = CGPoint(x: -size.width * 0.24413146, y: -size.height * 0.0990916)
        
        line2 = childNode(withName: "line2") as? SKSpriteNode
        line2?.position = CGPoint(x: size.width * 0.01897418, y: -size.height * 0.09792112)
        
        line3 = childNode(withName: "line3") as? SKSpriteNode
        line3?.position = CGPoint(x: size.width * 0.25742723, y: -size.height * 0.09018575)
        
        sound = childNode(withName: "sound") as? SKSpriteNode
        sound?.name = "sound"
        sound?.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        sound?.size =  CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        
        if UserDefaults.standard.bool(forKey: "isMissionOnePassed") {
            cardTwo.size = CGSize(width: 161.216, height: 191.397)
            cardTwo.texture = SKTexture(imageNamed: "cardStage2")
            cardTwo.position = CGPoint(x: -size.width * 0.11267606, y: -size.height * 0.20468957)
            cardTwoAnimation(for: cardTwo)
            isCardOneAnimating = false
            cardOne.removeAllActions()
                       
        } else {
            cardTwo.size = CGSize(width: 120, height: 150)
            cardTwo.texture = SKTexture(imageNamed: "cardLock2")
            cardTwo.position = CGPoint(x: -size.width * 0.11267606, y: -size.height * 0.20468957)
        }
        
//        if UserDefaults.standard.bool(forKey: "isMissionTwoPassed") {
//            blockCardTwo.size = CGSize(width: 120, height: 150)
//            blockCardTwo.texture = SKTexture(imageNamed: "cardLock")
//            blockCardTwo.position = CGPoint(x: size.width * 0.13360094, y: -size.height * 0.00876081)
//            
//            blockCardThree.size = CGSize(width: 120, height: 150)
//            blockCardThree.texture = SKTexture(imageNamed: "cardLock")
//            blockCardThree.position = CGPoint(x: size.width * 0.38125352, y: -size.height * 0.18687786)
//            
//        } else {
//            blockCardTwo.size = CGSize(width: 120, height: 150)
//            blockCardTwo.texture = SKTexture(imageNamed: "cardLock1")
//            blockCardTwo.position = CGPoint(x: size.width * 0.13360094, y: -size.height * 0.00876081)
//            
//            blockCardThree.size = CGSize(width: 120, height: 150)
//            blockCardThree.texture = SKTexture(imageNamed: "cardLock1")
//            blockCardThree.position = CGPoint(x: size.width * 0.38125352, y: -size.height * 0.18687786)
//        }
        
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        SoundManager.shared.stopVoiceStory3()
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            SoundManager.shared.playCardPerSceneSound()
            sound?.texture = soundOnTexture
        }
        else{
            SoundManager.shared.stopCardPerSceneSound()
            sound?.texture = soundOffTexture
        }
        if isCardOneAnimating {
            cardOneAnimation(for: cardOne)
        }
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
                        SoundManager.shared.stopCardPerSceneSound()
                    } else {
                        sound?.texture = soundOnTexture
                        
                        UserDefaults.standard.set(true, forKey: "SoundActive")
                        SoundManager.shared.playCardPerSceneSound()
                    }
                }
                
                if node.name == "infoCharacter" {
                    if let scene = SKScene(fileNamed: "CharacterScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
                
                if node.name == "infoSejarah" {
                    if let scene = SKScene(fileNamed: "StorySatu") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
                
                if node.name == "cardOne" {
                    if let scene = SKScene(fileNamed: "MissionOneScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
                
                if node.name == "cardTwo" && UserDefaults.standard.bool(forKey: "isMissionOnePassed") {
                    if let scene = SKScene(fileNamed: "MissionTwoScene") {
                        cardTwoAnimation(for: cardTwo)
                        isCardOneAnimating = false  // Stop cardOne animation
                        cardOne.removeAllActions()
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
            }
        }
    }
    
    func cardOneAnimation (for cardOne: SKSpriteNode){
        let cardOneAction = SKAction.animate(with: animasiTextures, timePerFrame: 0.7)
        let cardOneSequence = SKAction.repeatForever(cardOneAction)
        
        cardOne.run(cardOneSequence)
    }
    
    func cardTwoAnimation (for cardTwo: SKSpriteNode){
        let cardTwoAction = SKAction.animate(with: animasiTwoTextures, timePerFrame: 0.7)
        let cardTwoSequence = SKAction.repeatForever(cardTwoAction)
        
        cardTwo.run(cardTwoSequence)
        cardOne.removeAllActions()
    }
}
