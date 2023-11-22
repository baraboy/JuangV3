//
//  StagesOne.swift
//  SemarangTempur
//
//  Created by Rizky Dwi Hadisaputro on 18/10/23.
//

import Foundation
import SpriteKit
import GameController

class StageOne: SKScene, SKPhysicsContactDelegate{
    
    var hero = SKSpriteNode()
    var heroTexture = SKTexture(imageNamed: "heroHiz")
    
    var ground = SKSpriteNode()
    var groundTexture = SKTexture(imageNamed: "ground")
    
    var settingsNode = SKSpriteNode()
    
    var boxdorong: SKSpriteNode!
    
    var gedungMarkas = SKSpriteNode()
    
    var pauseButton: SKSpriteNode!

    var backgroundMenu: SKSpriteNode!
    var settingsMenu: SKSpriteNode!
    var lanjutMenu: SKSpriteNode!
    var keluarMenu: SKSpriteNode!
    
    var backgroundWin: SKSpriteNode!
    var settingsWin: SKSpriteNode!
    var lanjutWin: SKSpriteNode!
    var keluarWin: SKSpriteNode!
    
    var backgroundLose: SKSpriteNode!
    var settingsLose: SKSpriteNode!
    var ulangiLose: SKSpriteNode!
    var keluarLose: SKSpriteNode!
    
    var soundCheck: SKSpriteNode!
    var musicCheck: SKSpriteNode!
    var vibrateCheck: SKSpriteNode!
    
    var isSoundEnabled = true
    var isMusicEnabled = true
    var isVibrateEnabled = true
    
    let soundKeys = SKAction.playSoundFileNamed("keysCollected.wav", waitForCompletion: false)
    
    var key = SKSpriteNode()
    var keyTwo = SKSpriteNode()
    var keyThree = SKSpriteNode()
    var keyFour = SKSpriteNode()
    var keyFive = SKSpriteNode()
    
    var virtualController: GCVirtualController?
    var heroposX : CGFloat = 0
    var heroMovedLeft = false
    var heroMovedRight = false
    var heroLooksRight = true
    var heroLooksLeft = false
    
    var isHeroChanged = false
    var isJumping = false
    var isSpeedActive = false
    
    var isButtonBPressed = false
    var isButtonAPressed = false
    var isInvincible = false
    
    var isButtonSkillPressed = false
    
    var cameraNode: SKCameraNode?
    
    private var numObjs = 0
    private var collectedKeys = 0
    private var label = SKLabelNode()
    
    var lives = 3
    private var live1: SKSpriteNode?
    private var live2: SKSpriteNode?
    private var live3: SKSpriteNode?
    
    var heartsArray = [SKSpriteNode]()
    let heartContainer = SKSpriteNode()
    
    var heroFrames = [SKTexture]()
    var textureAtlaas = SKTextureAtlas(named: "heroHizWalkAnimation")
    var heroState: HeroState = .normal
    
    var skillNode = SKSpriteNode(imageNamed: "buttonJump")
    
    private var heroHizIdleAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "heroHizIdleAnimation")
    }
    
    private var heroHizIdleTextures: [SKTexture] {
        return [
            heroHizIdleAtlas.textureNamed("heroHizIdle0"),
            heroHizIdleAtlas.textureNamed("heroHizIdle1")
        ]
    }
    
    private var heroHizJumpAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "heroHizJumpAnimation")
    }
    
    private var heroHizJumpTextures: [SKTexture] {
        return [
            heroHizJumpAtlas.textureNamed("heroHizJump0"),
            heroHizJumpAtlas.textureNamed("heroHizJump1"),
            heroHizJumpAtlas.textureNamed("heroHizJump2"),
            heroHizJumpAtlas.textureNamed("heroHizJump3"),
            heroHizJumpAtlas.textureNamed("heroHizJump4"),
            heroHizJumpAtlas.textureNamed("heroHizJump5"),
            heroHizJumpAtlas.textureNamed("heroHizJump6")
        ]
    }
    
    private var heroBantPushAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "heroBantPushAnimation")
    }
    
    private var heroBantPushTextures: [SKTexture] {
        return [
            heroBantPushAtlas.textureNamed("heroBantPush0"),
            heroBantPushAtlas.textureNamed("heroBantPush1"),
            heroBantPushAtlas.textureNamed("heroBantPush2"),
            heroBantPushAtlas.textureNamed("heroBantPush3"),
            heroBantPushAtlas.textureNamed("heroBantPush4"),
            heroBantPushAtlas.textureNamed("heroBantPush5")
        ]
    }
    
    enum bitMask: UInt32 {
        case hero = 0b1
        case ground = 0b10
        case box = 0b100
        case duri = 0b1000
        case keyCategory = 0b10000
        case gedung = 0b100000
    }
    
    enum HeroState {
        case normal
        case transformed
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopSpyMusic()
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        SoundManager.shared.stopVoiceStory3()
        
        self.physicsWorld.contactDelegate = self
        
        cameraNode = childNode(withName: "Camera") as? SKCameraNode
        
        //label.position = CGPoint(x: (cameraNode?.position.x)! - 60 , y: size.height * 0.39440204)
        label.position = CGPoint(x: frame.midX - 100, y: frame.midY - 45)
        label.horizontalAlignmentMode = .right
        label.fontName = "SF Pro Rounded Semibold"
        label.fontSize = 22
        label.text = String(collectedKeys) + "/5"
        label.fontColor = .black
        label.zPosition = 5
        cameraNode?.addChild(label)
        
        let keyNode = SKSpriteNode(imageNamed: "coloredKey")
        keyNode.position = CGPoint(x: frame.midX - 90, y: frame.midY - 40)
        keyNode.size = CGSize(width: 50, height: 50)
        keyNode.zPosition = 5
        cameraNode?.addChild(keyNode)
        
        backgroundMenu = SKSpriteNode(imageNamed: "backgroundPause")
        backgroundMenu.zPosition = 51
        backgroundMenu.position = CGPoint(x: 0, y:0 )
        backgroundMenu.isHidden = true
        cameraNode?.addChild(backgroundMenu)
        
        settingsMenu = SKSpriteNode(imageNamed: "pauseSettings")
        settingsMenu.zPosition = 52
        settingsMenu.position = CGPoint(x: 0, y:0 )
        settingsMenu.size = CGSize(width: 258, height: 258)
        backgroundMenu.addChild(settingsMenu)
        
        lanjutMenu = SKSpriteNode(imageNamed: "buttonExitV2")
        lanjutMenu.zPosition = 53
        lanjutMenu.position = CGPoint(x: 120, y: 120)
        lanjutMenu.name = "lanjutMenu"
        backgroundMenu.addChild(lanjutMenu)
        
        soundCheck = SKSpriteNode(imageNamed: "checked")
        soundCheck.zPosition = 53
        soundCheck.position = CGPoint(x: 87, y: 54)
        soundCheck.name = "soundCheck"
        backgroundMenu.addChild(soundCheck)
        
        musicCheck = SKSpriteNode(imageNamed: "checked")
        musicCheck.zPosition = 53
        musicCheck.position = CGPoint(x: 87, y: 14)
        musicCheck.name = "musicCheck"
        backgroundMenu.addChild(musicCheck)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            isMusicEnabled = true
            SoundManager.shared.playGameMusic()
        }
        else {
            isMusicEnabled = false
            SoundManager.shared.stopGameMusic()
        }
        musicCheck.texture = isMusicEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
        
        vibrateCheck = SKSpriteNode(imageNamed: "checked")
        vibrateCheck.zPosition = 53
        vibrateCheck.position = CGPoint(x: 87, y: -25)
        vibrateCheck.name = "vibrateCheck"
        backgroundMenu.addChild(vibrateCheck)
        
        keluarMenu = SKSpriteNode(imageNamed: "buttonKeluarCard")
        keluarMenu.zPosition = 53
        keluarMenu.position = CGPoint(x: 0, y: -84)
        keluarMenu.size = CGSize(width: 198, height: 48)
        keluarMenu.name = "keluarMenu"
        backgroundMenu.addChild(keluarMenu)
        
        pauseButton = SKSpriteNode(imageNamed: "pauseButton")
        pauseButton.position = CGPoint(x: frame.midX - 52.5, y: frame.midY - 40)
        pauseButton.size = CGSize(width: 40, height: 40)
        pauseButton.name = "pauseButton"
        pauseButton.zPosition = 5
        cameraNode?.addChild(pauseButton)
        
        backgroundWin = SKSpriteNode(imageNamed: "backgroundPause")
        backgroundWin.zPosition = 51
        backgroundWin.position = CGPoint(x: 0, y:0 )
        backgroundWin.isHidden = true
        cameraNode?.addChild(backgroundWin)
        
        settingsWin = SKSpriteNode(imageNamed: "settingsWin")
        settingsWin.zPosition = 52
        settingsWin.size = CGSize(width: 300, height: 300)
        settingsWin.position = CGPoint(x: 0, y:0 )
        backgroundWin.addChild(settingsWin)
        
        lanjutWin = SKSpriteNode(imageNamed: "lanjutWin")
        lanjutWin.zPosition = 53
        lanjutWin.size = CGSize(width: 208, height: 48)
        lanjutWin.position = CGPoint(x: 0, y: -95)
        lanjutWin.name = "lanjutWin"
        backgroundWin.addChild(lanjutWin)
        
        keluarWin = SKSpriteNode(imageNamed: "keluarWin")
        keluarWin.zPosition = 53
        keluarWin.size = CGSize(width: 40, height: 40)
        keluarWin.position = CGPoint(x: 135, y: 140)
        keluarWin.name = "keluarWin"
        backgroundWin.addChild(keluarWin)
        
        backgroundLose = SKSpriteNode(imageNamed: "backgroundPause")
        backgroundLose.zPosition = 51
        backgroundLose.position = CGPoint(x: 0, y:0 )
        backgroundLose.isHidden = true
        cameraNode?.addChild(backgroundLose)
        
        settingsLose = SKSpriteNode(imageNamed: "settingsLose")
        settingsLose.zPosition = 52
        settingsLose.size = CGSize(width: 300, height: 300)
        settingsLose.position = CGPoint(x: 0, y:0 )
        backgroundLose.addChild(settingsLose)
        
        ulangiLose = SKSpriteNode(imageNamed: "ulangiLose")
        ulangiLose.zPosition = 53
        ulangiLose.size = CGSize(width: 208, height: 48)
        ulangiLose.position = CGPoint(x: 0, y: -95)
        ulangiLose.name = "ulangiLose"
        backgroundLose.addChild(ulangiLose)
        
        keluarLose = SKSpriteNode(imageNamed: "keluarLose")
        keluarLose.zPosition = 53
        keluarLose.size = CGSize(width: 40, height: 40)
        keluarLose.position = CGPoint(x: 135, y: 140)
        keluarLose.name = "keluarLose"
        backgroundLose.addChild(keluarLose)
        
        skillNode.name = "buttonSkill"
        
        heartContainer.position = (CGPoint(x: -frame.midX + 50, y: frame.midY - 40))
        heartContainer.zPosition = 5
        cameraNode?.addChild(heartContainer)
        fillHearts(count: 3)
        
        for i in 0..<textureAtlaas.textureNames.count{
            let textureNames = "heroHizWalk" + String(i)
            heroFrames.append(textureAtlaas.textureNamed(textureNames))
        }
        
        for node in self.children {
            if (node.name == "Kotak"){
                if let someTileMap: SKTileMapNode = node as?
                    SKTileMapNode{
                    tileMapPhysicsBodyBox(map: someTileMap)
                    
                    someTileMap.removeFromParent()
                }
            }
        }
        
        for node in self.children {
            if node.name == "Duri" {
                if let spikeTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tileMapPhysicsBodyForSpikes(map: spikeTileMap)
                    
                    spikeTileMap.removeFromParent()
                }
            }
        }
        
        addHero()
        addGround()
        addGround2()
        addGround3()
        addGround4()
        addBox()
        
        addKey()
        addKeyTwo()
        addKeyThree()
        addKeyFour()
        addKeyFive()
        
        addGedungMarkasWinSituation()
        
        connectVirtualController()
        
        addSkillNode()
        
    }
    
    deinit {
        // Remove observers when the scene is deallocated
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Application Lifecycle Methods

    @objc func applicationWillResignActive() {
        // Pause the game when the app goes to the background
        pauseGame()
    }

    @objc func applicationDidBecomeActive() {
        // Resume the game when the app becomes active again
        resumeGame()
    }

    // Add these methods to pause and resume the game
    func pauseGame() {
        // Pause any ongoing actions, animations, or game logic here
        self.isPaused = true
        print("pauseGame")
    }

    func resumeGame() {
        // Resume the game when the app becomes active again
        self.isPaused = true
        backgroundMenu.isHidden = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
//        if contact.bodyA.categoryBitMask == bitMask.ground.rawValue || contact.bodyB.categoryBitMask == bitMask.ground.rawValue {
//            isJumping = false
//        }
//        else if contact.bodyA.categoryBitMask == bitMask.box.rawValue || contact.bodyB.categoryBitMask == bitMask.box.rawValue {
//            isJumping = false
//        }
//        
        //collected key
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == bitMask.hero.rawValue | bitMask.keyCategory.rawValue {
            collectedKeys += 1
            if isSoundEnabled{
                run(soundKeys)
            }
            print(collectedKeys)
            label.text = "\(collectedKeys)/5"
            if bodyA == "key" {
                contact.bodyA.node?.removeFromParent()
                print("contact dengan key")
                //HapticManager.instance.impact(style: .heavy)
            }
            else {
                contact.bodyB.node?.removeFromParent()
                //HapticManager.instance.impact(style: .heavy)
            }
        }
        
        if collision == bitMask.hero.rawValue | bitMask.duri.rawValue && !isInvincible {
            lives -= 1
            print("Hero hit a spike! Lives left: \(lives)")
            isInvincible = true
            isJumping = false
            //HapticManager.instance.impact(style: .heavy)
            if isVibrateEnabled{
                HapticManager.instance.notification(type: .error)
            }
            
            let lastElementIndex = heartsArray.count - 1
            if heartsArray.indices.contains(lastElementIndex - 1) {
                let lastHeart = heartsArray[lastElementIndex]
                lastHeart.removeFromParent()
                heartsArray.remove(at: lastElementIndex)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isInvincible = false
                    self.hero.removeAllActions()
                }
            }
            //blinkHero()
            knockBackHero()
        }
        
        // finish
        if collision == bitMask.hero.rawValue | bitMask.gedung.rawValue && collectedKeys == 5 {
            self.isPaused = true
            backgroundWin.isHidden = false
            
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "isMissionOnePassed")
            
        }
        
        if !isMusicEnabled{
            SoundManager.shared.stopGameMusic()
        }
    }
    
//    func didEnd(_ contact: SKPhysicsContact) {
//        if contact.bodyA.categoryBitMask == bitMask.ground.rawValue || contact.bodyB.categoryBitMask == bitMask.ground.rawValue {
//            isJumping = true
//        }
//        else if contact.bodyA.categoryBitMask == bitMask.box.rawValue || contact.bodyB.categoryBitMask == bitMask.box.rawValue {
//            isJumping = true
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "buttonSkill" {
                    print( "Berhasil nekan")
                    switch heroState {
                    case .normal:
                        if !isJumping{
                            if isVibrateEnabled{
                                HapticManager.instance.impact(style: .medium)
                            }
                            startHizJumpAnimation()
                            //hero.physicsBody?.velocity.dy = 0
                           
                            if heroMovedLeft || heroLooksLeft{
                                hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
                            }
                            else if heroLooksRight || heroLooksRight{
                                hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
                            }
                            //isJumping = true
                            boxdorong.physicsBody?.isDynamic = false
                        }
                    case .transformed:
                        startBantPushAnimation()
                        boxdorong.physicsBody?.isDynamic = true
                        
                        if isVibrateEnabled{
                            HapticManager.instance.impact(style: .medium)
                        }
                    }
                }
                if node.name == "pauseButton" || node.name == "lanjutMenu"{
                    if self.isPaused {
                        self.isPaused = false
//                        pauseButton.texture = pauseButtonTexture
                        backgroundMenu.isHidden = true
                    } else {
                        self.isPaused = true
                        //print("pause")
//                        pauseButton.texture = resumeButtonTexture
                        backgroundMenu.isHidden = false
                    }
                }
                
                if node.name == "keluarWin" {
                    virtualController = nil
                    SoundManager.shared.stopGameMusic()
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "CardPerStageScene") { 
                            let transition = SKTransition.fade(withDuration: 0.5)
                            scene.scaleMode = .resizeFill
                            view.presentScene(scene, transition: transition)
                            
                        }
                    }
                }
                
                if node.name == "lanjutWin"{
                    virtualController = nil
                    SoundManager.shared.stopGameMusic()
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "CardPerStageScene") {
                            let transition = SKTransition.fade(withDuration: 0.5)
                            scene.scaleMode = .resizeFill
                            view.presentScene(scene, transition: transition)
                        }
                    }
                }
                
                if node.name == "ulangiLose"{
                    virtualController = nil
                    if let view = self.view {
                        // Load the SKScene from 'GameOverScene.sks'
                        if let scene = SKScene(fileNamed: "StageOne") {
                            
                            let transition = SKTransition.fade(withDuration: 0.5)
                            print("Stages One Scene")
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .resizeFill
                            // Present the scene
                            view.presentScene(scene, transition: transition)
                            print("Stages One Scene displayed")
                        }
                    }
                }
                
                if node.name == "keluarLose" {
                    virtualController = nil
                    SoundManager.shared.stopGameMusic()
                    if let view = self.view {
                        // Load the SKScene from 'GameOverScene.sks'
                        if let scene = SKScene(fileNamed: "CardPerStageScene") {
                            
                            let transition = SKTransition.fade(withDuration: 0.5)
                            print("Card per Stages Scene")
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .resizeFill
                            // Present the scene
                            view.presentScene(scene, transition: transition)
                            print("Card per Stages Scene displayed")
                        }
                    }
                }
                
                if node.name == "keluarMenu" {
                    SoundManager.shared.stopGameMusic()
                    if let scene = SKScene(fileNamed: "CardPerStageScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
                
                if node.name == "soundCheck" {
                    isSoundEnabled.toggle()
                    soundCheck.texture = isSoundEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
                }
                
                if node.name == "musicCheck" {
                    isMusicEnabled.toggle()
                    musicCheck.texture = isMusicEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
                    if !isMusicEnabled{
                        SoundManager.shared.stopGameMusic()
                        UserDefaults.standard.set(false, forKey: "SoundActive")
                    }
                    else{
                        SoundManager.shared.playGameMusic()
                        UserDefaults.standard.set(true, forKey: "SoundActive")
                    }
                    
                }
                
                if node.name == "vibrateCheck" {
                    isVibrateEnabled.toggle()
                    vibrateCheck.texture = isVibrateEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "buttonSkill" {
                    print( "Berhasil nekan")
                    switch heroState {
                    case .normal:
//                        if !isJumping{
//                            //startHizJumpAnimation()
//                            hero.physicsBody?.velocity.dy = 0
//                            hero.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 120))
//                            //isJumping = true
//                        }
                        hero.removeAction(forKey: "heroHizWalkAnimation")
                        boxdorong.physicsBody?.isDynamic = false
                    case .transformed:
                        hero.removeAction(forKey: "heroBantPushAnimation")
                        boxdorong.physicsBody?.isDynamic = false
                    }
                }
                
                if node.name == hero.name {
                    switch heroState {
                    case .normal:
                        // Change the hero to a new state
                        let newHeroTexture = SKTexture(imageNamed: "heroBant")
                        hero.texture = newHeroTexture
                        heroFrames = createHeroFrames(textureAtlasName: "heroBantWalkAnimation")
                        let newSkillNodeTexture = SKTexture(imageNamed: "buttonPush")
                        skillNode.texture = newSkillNodeTexture
                        isHeroChanged = true
                        heroState = .transformed
                    case .transformed:
                        // Change the hero back to its original state
                        hero.texture = heroTexture
                        let newSkillNodeTexture = SKTexture(imageNamed: "buttonJump")
                        skillNode.texture = newSkillNodeTexture
                        heroFrames = createHeroFrames(textureAtlasName: "heroHizWalkAnimation")
                        isHeroChanged = false
                        heroState = .normal
                    }
                }
                
//                if node.name == "musicCheck" {
//                    isMusicEnabled.toggle()
//                    musicCheck.texture = isMusicEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
//                    
//                    if isMusicEnabled {
//                        run(SKAction.repeatForever(songPlaying))
//                    } else {
//                        removeAllActions()
//                    }
//                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        heroposX = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)

        if heroposX >= 0.1 {
            if heroMovedRight == false {
                hero.run(SKAction.repeatForever(SKAction.animate(with: heroFrames, timePerFrame: 0.05)))
                heroMovedRight = true
                heroMovedLeft = false
            }
            if isSpeedActive{
                hero.position.x += (heroposX * 8.0)
                camera?.position.x += (heroposX * 8.0)
            }
            else{
                hero.position.x += (heroposX * 4.0)
                camera?.position.x += (heroposX * 4.0)
            }
            if heroLooksLeft == true {
                hero.xScale = -hero.xScale
            }
            heroLooksRight = true
            heroLooksLeft = false
        } 
        else if heroposX <= -0.1 {
            if heroMovedLeft == false {
                hero.run(SKAction.repeatForever(SKAction.animate(with: heroFrames, timePerFrame: 0.05)))
                heroMovedLeft = true
                heroMovedRight = false
            }
            if isSpeedActive{
                hero.position.x -= (-heroposX * 8.0)
                camera?.position.x -= (-heroposX * 8.0)
            }
            else{
                hero.position.x -= -(heroposX * 4.0)
                camera?.position.x -= -(heroposX * 4.0)
            }
            if heroLooksRight == true {
                hero.xScale = -hero.xScale
            }
            heroLooksRight = false
            heroLooksLeft = true
        } else {
            hero.removeAllActions()
            heroMovedRight = false
            heroMovedLeft = false
        }
        
        if let atGround = hero.physicsBody?.velocity {
            if atGround.dy == 0 {
                isJumping = false
            } else {
                isJumping = true
            }
        }
        
        let leftBoundary: CGFloat = 0
        let rightBoundary: CGFloat = 2600
        let upperBoundary: CGFloat = 350
        
        if hero.position.y >= upperBoundary {
            hero.position.y = upperBoundary
        }
        
        if hero.position.x <= leftBoundary {
            hero.position.x = leftBoundary
        }
        
        // Check if the character is at the right boundary
        if hero.position.x >= rightBoundary {
            hero.position.x = rightBoundary
        }
        
        camera?.position.x = hero.position.x + 125
        //camera?.position.y = hero.position.y
        
        if lives <= 0 {
            print("Game Over")
            self.isPaused = true
            backgroundLose.isHidden = false
        }
        
        
    }
    
    func connectVirtualController(){
        
        let controllerConfig = GCVirtualController.Configuration()
        controllerConfig.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controllerConfig)
        controller.connect()
        virtualController = controller
    }
    
    func createHeroFrames(textureAtlasName: String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: textureAtlasName)
        var frames = [SKTexture]()
        let prefix = textureAtlasName.replacingOccurrences(of: "Animation", with: "")
        for i in 1..<textureAtlas.textureNames.count {
            let textureName = prefix + String(i)
            frames.append(textureAtlas.textureNamed(textureName))
        }
        return frames
    }
    
    func startHizIdleAnimation(){
        let idleAnimation = SKAction.animate(with: heroHizIdleTextures, timePerFrame: 0.5)
        hero.run(SKAction.repeatForever(idleAnimation), withKey: "heroHizIdleAnimation")
    }
    
    func startHizJumpAnimation(){
        let jumpAnimation = SKAction.animate(with: heroHizJumpTextures, timePerFrame: 0.1)
        hero.run(SKAction.repeatForever(jumpAnimation), withKey: "heroHizJumpAnimation")
    }
        
    func startBantPushAnimation(){
        let pushAnimation = SKAction.animate(with: heroBantPushTextures, timePerFrame: 0.1)
        hero.run(SKAction.repeatForever(pushAnimation), withKey: "heroBantPushAnimation")
    }
    
    func addHero(){
        hero = childNode(withName: "hero") as! SKSpriteNode
        let heroSize = hero.size
        let smallerSize = CGSize(width: heroSize.width * 0.6, height: heroSize.height * 0.9)
        hero.physicsBody = SKPhysicsBody(rectangleOf: smallerSize)
        //hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.categoryBitMask = bitMask.hero.rawValue
        hero.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.box.rawValue | bitMask.duri.rawValue
        hero.physicsBody?.collisionBitMask = bitMask.ground.rawValue | bitMask.box.rawValue | bitMask.duri.rawValue
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.allowsRotation = false
    }
    
//    func blinkHero() {
//        let blinkAction = SKAction.sequence([
//            SKAction.setTexture(SKTexture(imageNamed: "herocry")),
//            SKAction.wait(forDuration: 1.0),
//            SKAction.setTexture(SKTexture(imageNamed: "hero")),
//            SKAction.wait(forDuration: 1.0)
//        ])
//        
//        let blinkForeverAction = SKAction.repeatForever(blinkAction)
//        
//        hero.run(blinkForeverAction)
//    }
    
    func knockBackHero() {
        let knockBackAction = SKAction.sequence([
            SKAction.moveBy(x: -300, y: 50, duration: 0.5),
            SKAction.moveBy(x: 300, y: 50, duration: 0.5)
        ])
        
        hero.run(knockBackAction)
        //hero.removeAllActions()
    }
    
    func addGround(){
        ground = childNode(withName: "ground2") as! SKSpriteNode
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = bitMask.ground.rawValue
        ground.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
        ground.physicsBody?.collisionBitMask = bitMask.hero.rawValue
        ground.physicsBody?.isDynamic = false
    }
    
    func addGround2(){
        ground = childNode(withName: "ground3") as! SKSpriteNode
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = bitMask.ground.rawValue
        ground.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
        ground.physicsBody?.collisionBitMask = bitMask.hero.rawValue
        ground.physicsBody?.isDynamic = false
    }
    
    func addGround3(){
        ground = childNode(withName: "ground4") as! SKSpriteNode
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = bitMask.ground.rawValue
        ground.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
        ground.physicsBody?.collisionBitMask = bitMask.hero.rawValue
        ground.physicsBody?.isDynamic = false
    }
    
    func addGround4(){
        ground = childNode(withName: "ground5") as! SKSpriteNode
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = bitMask.ground.rawValue
        ground.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
        ground.physicsBody?.collisionBitMask = bitMask.hero.rawValue
        ground.physicsBody?.isDynamic = false
    }
    
    func tileMapPhysicsBodyBox(map: SKTileMapNode){
        
        let tileMap = map
        let startLocation: CGPoint = tileMap.position
        let tileSize = tileMap.tileSize
        let halfwidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfheight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfwidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfheight + (tileSize.height / 2)
                    
                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    let boxSize = tileNode.size
                    let smallerSize = CGSize(width: boxSize.width * 0.7, height: boxSize.height * 0.9)
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: smallerSize)
                    tileNode.physicsBody?.categoryBitMask = bitMask.box.rawValue
                    tileNode.physicsBody?.collisionBitMask = bitMask.hero.rawValue
                    tileNode.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
                    
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.zPosition = 20
                    //                    tileNode.anchorPoint = .zero
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + startLocation.x, y: tileNode.position.y + startLocation.y)
                    
                    self.addChild(tileNode)
                }
            }
        }
    }
    
    func tileMapPhysicsBodyForSpikes(map: SKTileMapNode) {
        let tileMap = map
        let startLocation: CGPoint = tileMap.position
        let tileSize = tileMap.tileSize
        let halfwidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfheight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfwidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfheight + (tileSize.height / 2)
                    
                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    let duriSize = tileNode.size
                    let smallerSize = CGSize(width: duriSize.width * 0.7, height: duriSize.height * 0.9)
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: smallerSize)
                    tileNode.physicsBody?.categoryBitMask = bitMask.duri.rawValue
                    tileNode.physicsBody?.collisionBitMask = bitMask.hero.rawValue
                    tileNode.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
                    
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.zPosition = 20
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + startLocation.x, y: tileNode.position.y + startLocation.y)
                    
                    self.addChild(tileNode)
                }
            }
        }
    }
    
    func fillHearts(count: Int) {
        for index in 1...count {
            let heart = SKSpriteNode(imageNamed: "lives")
            heart.xScale = 0.1
            heart.yScale = 0.1
            let xPosition = (heart.size.width + 5) * CGFloat(index - 1)
            heart.position = CGPoint(x: xPosition, y: 0)
            heartsArray.append(heart)
            heartContainer.addChild(heart)
        }
    }
    
    func addBox() {
        boxdorong = childNode(withName: "box") as? SKSpriteNode
        
        let boxSize = boxdorong.size
        let boxBig = CGSize(width: boxSize.width * 1.1, height: boxSize.height)
        boxdorong.physicsBody = SKPhysicsBody(rectangleOf: boxBig)
        boxdorong.physicsBody?.isDynamic = false
        boxdorong.physicsBody?.affectedByGravity = true
        boxdorong.physicsBody?.allowsRotation = false
        boxdorong.physicsBody?.categoryBitMask = bitMask.ground.rawValue
    }
    
    func addKey() {
        key = childNode(withName: "key") as! SKSpriteNode
        
        let keySize = key.size
        let keySmall = CGSize(width: keySize.width * 0.3, height: keySize.height * 0.7)
        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        key.physicsBody?.allowsRotation = false
        key.name = "key"
    }
    
    func addKeyTwo() {
        key = childNode(withName: "keyTwo") as! SKSpriteNode
        
        let keySize = key.size
        let keySmall = CGSize(width: keySize.width * 0.3, height: keySize.height * 0.7)
        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        key.physicsBody?.allowsRotation = false
        key.name = "keyTwo"
    }
    
    func addKeyThree() {
        key = childNode(withName: "keyThree") as! SKSpriteNode
        
        let keySize = key.size
        let keySmall = CGSize(width: keySize.width * 0.3, height: keySize.height * 0.7)
        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        key.physicsBody?.allowsRotation = false
        key.name = "keyThree"
    }
    
    func addKeyFour() {
        key = childNode(withName: "keyFour") as! SKSpriteNode
        
        let keySize = key.size
        let keySmall = CGSize(width: keySize.width * 0.3, height: keySize.height * 0.7)
        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        key.physicsBody?.allowsRotation = false
        key.name = "keyFour"
    }
    
    func addKeyFive() {
        key = childNode(withName: "keyFive") as! SKSpriteNode
        
        let keySize = key.size
        let keySmall = CGSize(width: keySize.width * 0.3, height: keySize.height * 0.7)
        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        key.physicsBody?.allowsRotation = false
        key.name = "keyFive"
    }
    
    func addGedungMarkasWinSituation() {
        gedungMarkas = childNode(withName: "markas") as! SKSpriteNode
        
        gedungMarkas.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 80, height: 300))
        gedungMarkas.physicsBody?.categoryBitMask = bitMask.gedung.rawValue
        gedungMarkas.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        gedungMarkas.physicsBody?.allowsRotation = false
        gedungMarkas.physicsBody?.isDynamic = false
        
        gedungMarkas.name = "gedungMarkas"
    }
    
    func addSkillNode() {
        skillNode.position = CGPoint(x: (cameraNode?.position.x)! - 140, y: frame.minY - 140)
        skillNode.size = CGSize(width: frame.width / 8.55, height: frame.height / 3.875)
        skillNode.zPosition = 50
        
        let childNode = SKSpriteNode()
        childNode.size = CGSize(width: skillNode.size.width * 2, height: skillNode.size.height * 2)
        childNode.position = CGPoint(x: 0, y: 0)
        
        skillNode.addChild(childNode)
        cameraNode?.addChild(skillNode)
    }
}

