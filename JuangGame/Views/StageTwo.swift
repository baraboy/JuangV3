//
//  StageTwo.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 07/11/23.
//

import SpriteKit
import GameController

class StageTwo: SKScene, SKPhysicsContactDelegate {
    
    var hero = SKSpriteNode()
    var heroTexture = SKTexture(imageNamed: "heroAmka")
    
    var jepangEnemy = SKSpriteNode()
    var jepangEnemyFrames = [SKTexture]()
    var jepangEnemyAtlas = SKTextureAtlas(named: "jepangEnemyAnimation")
    
    //ini disimpan dulu
    var variantFrames = [SKTexture]()
    var variantAtlas = SKTextureAtlas(named: "variantAnimation")
    
    var ground = SKSpriteNode()
    var groundTexture = SKTexture(imageNamed: "ground")
    
    var heroFrames = [SKTexture]()
    var textureAtlaas = SKTextureAtlas(named: "heroAmkaWalk")
    var heroState: HeroState = .normal
    var cahaya: SKSpriteNode!
    var redNode: SKSpriteNode!
    
    var virtualController: GCVirtualController?
    var heroposX : CGFloat = 0
    var heroMovedLeft = false
    var heroMovedRight = false
    var heroLooksRight = true
    var heroLooksLeft = false
    
    var isHeroChanged = false
    var isJumping = false
    var isSpeedActive = false
    
    var isInvincible = false
    
    var cameraNode: SKCameraNode?
    
    var skillNode = SKSpriteNode(imageNamed: "buttonTech1")
    
    //Mini Games
    var tuasLampu = SKSpriteNode()
    var tuasLampu2 = SKSpriteNode()
    var matiLampu: SKSpriteNode?
    var remang = SKSpriteNode()
    var lampu = SKSpriteNode()
    var lampu1 = SKSpriteNode()
    var lampu2 = SKSpriteNode()
    var cahayatuas = SKSpriteNode()
    var putusListrik = false
    
    //Tes Buat Mini Games
    var keluarMiniGames: SKSpriteNode!
    var backgroundMiniGames: SKSpriteNode!
    var redSwitch = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var isSwitchTapped = [false, false, false, false]
    var variant: SKSpriteNode!
    var nodeClicked = 0
    //var blackNode: SKSpriteNode!
    var isJepangHidden = true
    var backgroundOverlayGames: SKSpriteNode!
    
    var backgroundLose: SKSpriteNode!
    var settingsLose: SKSpriteNode!
    var ulangiLose: SKSpriteNode!
    var keluarLose: SKSpriteNode!
    
    var backgroundWin: SKSpriteNode!
    var settingsWin: SKSpriteNode!
    var lanjutWin: SKSpriteNode!
    var keluarWin: SKSpriteNode!
    
    var settingsNode = SKSpriteNode()
    var soundCheck: SKSpriteNode!
    var musicCheck: SKSpriteNode!
    var vibrateCheck: SKSpriteNode!
    
    var isSoundEnabled = true
    var isMusicEnabled = true
    var isVibrateEnabled = true
    
    var pauseButton: SKSpriteNode!

    var backgroundMenu: SKSpriteNode!
    var settingsMenu: SKSpriteNode!
    var lanjutMenu: SKSpriteNode!
    var keluarMenu: SKSpriteNode!
    
    var lives = 3
    private var live1: SKSpriteNode?
    private var live2: SKSpriteNode?
    private var live3: SKSpriteNode?
    
    var heartsArray = [SKSpriteNode]()
    let heartContainer = SKSpriteNode()
    
    var key = SKSpriteNode()
    private var collectedKeys = 0
    private var labelKeys = SKLabelNode()
    let soundKeys = SKAction.playSoundFileNamed("keysCollected.wav", waitForCompletion: false)
    
    private var timerNode = SKLabelNode()
    private var ellipse = SKShapeNode()
    var time: Int = 21 {
        didSet {
            if time >= 10 {
                timerNode.text = "\(time)"
            } else {
                timerNode.text = "\(time)"
            }
        }
    }
    
    private func countDown() -> Void {
        if time <= 0 {
            time = 0
            timerNode.isHidden = true
            ellipse.isHidden = true
            isJepangHidden = false
            jepangEnemy.isHidden = false
            redNode.isHidden = true
            turnOnTheLamp()
        } else {
            time -= 1
        }
    }
    
    var boxSenjata = SKSpriteNode()
    
    var boxDorong = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var trap = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var buttonObstacle = SKSpriteNode()
    
    let trapAtlas = SKTextureAtlas(named: "trapObstacle")
    var animasiTrapTextures: [SKTexture] = []
    
    
    var isLampTurnOn = false
    let boxAtlas = SKTextureAtlas(named: "boxAnimation")
    var animasiTextures: [SKTexture] = []
    var isBoxTapped = false
    
    private var movingObjects: [SKSpriteNode] = []
    
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
    
    private var heroAmrIdleAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "heroAmrIdleAnimation")
    }
    
    private var heroAmrIdleTextures: [SKTexture] {
        return [
            heroAmrIdleAtlas.textureNamed("heroAmrIdle0"),
            heroAmrIdleAtlas.textureNamed("heroAmrIdle1")
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
    
    private var heroAmkaMachAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "heroAmkaMachAnimation")
    }
    
    private var heroAmkaMachTextures: [SKTexture] {
        return [
            heroAmkaMachAtlas.textureNamed("heroAmkMach0"),
            heroAmkaMachAtlas.textureNamed("heroAmkMach1"),
            heroAmkaMachAtlas.textureNamed("heroAmkMach2")
        ]
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        self.physicsWorld.contactDelegate = self
        //SoundManager.shared.playSpyMusic()
        SoundManager.shared.stopCardPerSceneSound()
        SoundManager.shared.stopGameMusic()
        SoundManager.shared.stopBackgroundMusic()
        SoundManager.shared.stopMulaiSceneSound()
        SoundManager.shared.stopVoiceStory1()
        SoundManager.shared.stopVoiceStory2()
        SoundManager.shared.stopVoiceStory3_1()
        SoundManager.shared.stopVoiceStory3_2()
        SoundManager.shared.stopVoiceStory4()
        SoundManager.shared.stopVoiceStory5()
        SoundManager.shared.stopVoiceStory6()
        
        cameraNode = childNode(withName: "Camera") as? SKCameraNode
        
        heroWalkAnimation()
        enemyJepangIdleAnimation()
        
        skillNode.name = "buttonSkill"
        
        labelKeys.position = CGPoint(x: frame.midX - 100, y: frame.midY - 45)
        labelKeys.horizontalAlignmentMode = .right
        labelKeys.fontName = "SF Pro Rounded Semibold"
        labelKeys.fontSize = 22
        labelKeys.text = String(collectedKeys) + "/5"
        labelKeys.fontColor = .white
        labelKeys.zPosition = 50
        cameraNode?.addChild(labelKeys)
        
        let keyNode = SKSpriteNode(imageNamed: "coloredKey")
        keyNode.position = CGPoint(x: frame.midX - 90, y: frame.midY - 40)
        keyNode.size = CGSize(width: 50, height: 50)
        keyNode.zPosition = 50
        cameraNode?.addChild(keyNode)
        
        addBackgroundMiniGames()
        
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
        
        heartContainer.position = CGPoint(x: -frame.midX + 50, y: frame.midY - 40)
        heartContainer.zPosition = 50
        cameraNode?.addChild(heartContainer)
        fillHearts(count: 3)
        
        backgroundMenu = SKSpriteNode(imageNamed: "backgroundPause")
        backgroundMenu.zPosition = 70
        backgroundMenu.position = CGPoint(x: 0, y:0 )
        backgroundMenu.isHidden = true
        cameraNode?.addChild(backgroundMenu)
        
        settingsMenu = SKSpriteNode(imageNamed: "pauseSettings")
        settingsMenu.zPosition = 70
        settingsMenu.position = CGPoint(x: 0, y:0 )
        settingsMenu.size = CGSize(width: 258, height: 258)
        backgroundMenu.addChild(settingsMenu)
        
        lanjutMenu = SKSpriteNode(imageNamed: "buttonExitV2")
        lanjutMenu.zPosition = 71
        lanjutMenu.position = CGPoint(x: 120, y: 120)
        lanjutMenu.name = "lanjutMenu"
        backgroundMenu.addChild(lanjutMenu)
        
        soundCheck = SKSpriteNode(imageNamed: "checked")
        soundCheck.zPosition = 71
        soundCheck.position = CGPoint(x: 87, y: 54)
        soundCheck.name = "soundCheck"
        backgroundMenu.addChild(soundCheck)
        
        musicCheck = SKSpriteNode(imageNamed: "checked")
        musicCheck.zPosition = 71
        musicCheck.position = CGPoint(x: 87, y: 14)
        musicCheck.name = "musicCheck"
        backgroundMenu.addChild(musicCheck)
        
        if UserDefaults.standard.bool(forKey: "SoundActive") {
            isMusicEnabled = true
            SoundManager.shared.playSpyMusic()
        }
        else {
            isMusicEnabled = false
            SoundManager.shared.stopSpyMusic()
        }
        musicCheck.texture = isMusicEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
        
        vibrateCheck = SKSpriteNode(imageNamed: "checked")
        vibrateCheck.zPosition = 71
        vibrateCheck.position = CGPoint(x: 87, y: -25)
        vibrateCheck.name = "vibrateCheck"
        backgroundMenu.addChild(vibrateCheck)
        
        keluarMenu = SKSpriteNode(imageNamed: "buttonKeluarCard")
        keluarMenu.zPosition = 71
        keluarMenu.position = CGPoint(x: 0, y: -84)
        keluarMenu.size = CGSize(width: 198, height: 48)
        keluarMenu.name = "keluarMenu"
        backgroundMenu.addChild(keluarMenu)
        
        pauseButton = SKSpriteNode(imageNamed: "pauseButton")
        pauseButton.position = CGPoint(x: frame.midX - 52.5, y: frame.midY - 40)
        pauseButton.size = CGSize(width: 40, height: 40)
        pauseButton.name = "pauseButton"
        pauseButton.zPosition = 50
        cameraNode?.addChild(pauseButton)
        
        backgroundOverlayGames = SKSpriteNode(imageNamed: "backgroundPause")
        backgroundOverlayGames.zPosition = 51
        backgroundOverlayGames.position = CGPoint(x: 0, y:0 )
        backgroundOverlayGames.isHidden = true
        cameraNode?.addChild(backgroundOverlayGames)
        
        addTimerNode()
        for i in 0..<boxAtlas.textureNames.count {
            let textureName = "boxAnimation\(i)"
            let texture = boxAtlas.textureNamed(textureName)
            animasiTextures.append(texture)
        }
        
        for i in 0..<textureAtlaas.textureNames.count{
            let textureNames = "heroAmkaWalk" + String(i)
            heroFrames.append(textureAtlaas.textureNamed(textureNames))
        }
        
        matiLampu = childNode(withName: "gelap") as? SKSpriteNode
        remang = childNode(withName: "remang") as! SKSpriteNode
        remang.isHidden = true
        
        lampu = childNode(withName: "lampuBangunan") as! SKSpriteNode
        lampu.isHidden = true
        
        lampu1 = childNode(withName: "lampuBangunan1") as! SKSpriteNode
        lampu1.isHidden = true
        
        lampu2 = childNode(withName: "lampuBangunan2") as! SKSpriteNode
        lampu2.isHidden = true
        
        cahayatuas = childNode(withName: "cahayatuas") as! SKSpriteNode
        cahayatuas.isHidden = false
        
        redNode = childNode(withName: "redNode") as? SKSpriteNode
        redNode.isHidden = true
        redNode.zPosition = 53
        redNode.size = CGSize(width: redNode.frame.width * 3, height: redNode.frame.height * 3)
        
        cahaya = SKSpriteNode(imageNamed: "cahaya")
        cahaya.size = CGSize(width: cahaya.size.width * 1.2 , height: cahaya.size.height * 1.2)
        cahaya.zPosition = 49
        cahaya.isHidden = false
        addChild(cahaya)
        
        for node in self.children {
            if (node.name == "Kotak"){
                if let someTileMap: SKTileMapNode = node as?
                    SKTileMapNode{
                    tileMapPhysicsBodyBox(map: someTileMap)
                    
                    someTileMap.removeFromParent()
                }
            }
        }
        
        
        for i in 0..<trapAtlas.textureNames.count {
            let textureName = "trapAnimation\(i)"
            let texture = trapAtlas.textureNamed(textureName)
            animasiTrapTextures.append(texture)
        }
        
        addHero()
        addGround()
        
        addKey()
        addBoxDorong()
        connectVirtualController()
        
        addTuasLampuLightSituation() //Mini Games
        addTuasLampuLight2Situation()
        
        addBoxSenjataWinSituation()
        
        //addLampuBangunan()
        
        addSkillNode()
        
        addTrap()
        addbuttonObstacle()
        addJepangEnemy()
        
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
        virtualController = nil
        print("pauseGame")
    }

    func resumeGame() {
        // Resume the game when the app becomes active again
        connectVirtualController()
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
//        else if contact.bodyA.categoryBitMask == bitMask.boxdorong.rawValue || contact.bodyB.categoryBitMask == bitMask.boxdorong.rawValue {
//            isJumping = false
//        }
        
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //collected keys
        if collision == bitMask.hero.rawValue | bitMask.keyCategory.rawValue {
            collectedKeys += 1
            run(soundKeys)
            labelKeys.text = "\(collectedKeys)/5"
            if bodyA == "key" {
                contact.bodyA.node?.removeFromParent()
            }
            else {
                contact.bodyB.node?.removeFromParent()
            }
        }
        
        //Jepang Enemy
        if collision == bitMask.hero.rawValue | bitMask.jepangEnemy.rawValue {
            
            if !isJepangHidden {
                lives -= 3
                let lastElementIndex = heartsArray.count - 1
                if heartsArray.indices.contains(lastElementIndex - 1) {
                    let lastHeart = heartsArray[lastElementIndex]
                    lastHeart.removeFromParent()
                    heartsArray.remove(at: lastElementIndex)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isInvincible = false
                        //self.hero.removeAllActions()
                    }
                }
            }
        }
        
        //Trap Condition
        if collision == bitMask.hero.rawValue | bitMask.trapSituation.rawValue && !isInvincible {
            lives -= 1
            isInvincible = false
            isJumping = false
            if isVibrateEnabled{
                HapticManager.instance.notification(type: .error)
            }
            
            for index in 1...6 {
                if hero.intersects(trap[index]) {
                    runTrapAnimation(for: trap[index])
                }
            }
            
            let lastElementIndex = heartsArray.count - 1
            if heartsArray.indices.contains(lastElementIndex - 1) {
                let lastHeart = heartsArray[lastElementIndex]
                lastHeart.removeFromParent()
                heartsArray.remove(at: lastElementIndex)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isInvincible = false
                    //self.hero.removeAllActions()
                }
            }
        }
        
        //Trap Animation
        func runTrapAnimation(for trap: SKSpriteNode) {
            let trapAction = SKAction.animate(with: animasiTrapTextures, timePerFrame: 0.3)
            let trapSequence = SKAction.sequence([trapAction])
            trap.run(trapSequence)
        }
        
        //Button Obstacle Condition
        if collision == bitMask.hero.rawValue | bitMask.buttonObstacle.rawValue && !isInvincible {
            lives -= 3
            isInvincible = false
            isJumping = false
            if isVibrateEnabled{
                HapticManager.instance.notification(type: .error)
            }
            SoundManager.shared.playAlarmSound()
            let lastElementIndex = heartsArray.count - 1
            if heartsArray.indices.contains(lastElementIndex - 1) {
                let lastHeart = heartsArray[lastElementIndex]
                lastHeart.removeFromParent()
                heartsArray.remove(at: lastElementIndex)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isInvincible = false
                    //self.hero.removeAllActions()
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        if contact.bodyA.categoryBitMask == bitMask.ground.rawValue || contact.bodyB.categoryBitMask == bitMask.ground.rawValue {
//            isJumping = true
//        }
//        else if contact.bodyA.categoryBitMask == bitMask.box.rawValue || contact.bodyB.categoryBitMask == bitMask.box.rawValue {
//            isJumping = true
//        }
//        else if contact.bodyA.categoryBitMask == bitMask.boxdorong.rawValue || contact.bodyB.categoryBitMask == bitMask.boxdorong.rawValue {
//            isJumping = true
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if let heroNode = self.childNode(withName: "hero"), heroNode.intersects(boxSenjata) {
                    for node in touchNode {
                        if node.name == "boxSenjata" {
                            if !isBoxTapped{
                                if collectedKeys == 5 {
                                    let openBoxAction = SKAction.animate(with: animasiTextures, timePerFrame: 0.5)
                                    let openBoxSequence = SKAction.sequence([openBoxAction])
                                    
                                    boxSenjata.run(openBoxSequence) {
                                        self.isBoxTapped = true
                                        let gunTexture = SKTexture(imageNamed: "gun")
                                        let gun = SKSpriteNode(texture: gunTexture)
                                        let gunWidth: CGFloat = 151.19
                                        let gunHeight: CGFloat = 118.058
                                        gun.size = CGSize(width: gunWidth, height: gunHeight)
                                        gun.zPosition = 50
                                        gun.position = CGPoint(x: 5450, y: 154)
                                        self.addChild(gun)
                                        
                                        
                                        let moveDistance: CGFloat = 10
                                        let moveDuration: TimeInterval = 2.0
                                        let initialPosition = gun.position
                                        let finalPosition = CGPoint(x: initialPosition.x, y: initialPosition.y + moveDistance)
                                        
                                        let moveAction = SKAction.move(to: finalPosition, duration: moveDuration)
                                        gun.run(moveAction)
                                    }
                                }
                            }
                            else {
                                self.isPaused = true
                                self.backgroundWin.isHidden = false
                            }
                        }
                    }
                }
                
                if node.name == "buttonSkill" {
                    //                    print( "Berhasil nekan")
                    switch heroState {
                    case .normal:
                        //Mini games
                        
                        if let tuasNode = nodeWithBitMask(bitMask: bitMask.tuas.rawValue), hero.intersects(tuasNode) && heroState == .normal {
                            virtualController = nil
                            self.isPaused = true
                            hero.isHidden = true
                            matiLampu?.zPosition = 1
                            cahaya.zPosition = 10
                            cahaya.isHidden = false
                            Character.shared.characterAnimationSkill(characterTexture: heroAmkaMachTextures, hero: hero, skill: Character.shared.amkaAnimationName)
                            backgroundMiniGames.isHidden = false
                            //blackNode.isHidden = false
                            backgroundOverlayGames.isHidden = false
                            if backgroundMiniGames.isHidden == false {
                                variantIdleAnimation()
                            }
                        }
                        
                        if let tuasNode2 = nodeWithBitMask(bitMask: bitMask.tuas2.rawValue), hero.intersects(tuasNode2) && heroState == .normal {
                            virtualController = nil
                            self.isPaused = true
                            hero.isHidden = true
                            timerNode.isHidden = false
                            matiLampu?.zPosition = 48
                            Character.shared.characterAnimationSkill(characterTexture: heroAmkaMachTextures, hero: hero, skill: Character.shared.amkaAnimationName)
                            backgroundMiniGames.isHidden = false
                            
                            if backgroundMiniGames.isHidden == false {
                                variantIdleAnimation()
                            }
                            backgroundOverlayGames.isHidden = false
                            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(countDown), SKAction.wait(forDuration: 1)])))
                        }
                        
                    case .transformed:
                        isSpeedActive = true
                    case .transformed1:
                        if !isJumping {
                            Character.shared.characterAnimationSkill(characterTexture: heroHizJumpTextures, hero: hero, skill: Character.shared.hizbullahAnimationName)
//                            hero.physicsBody?.velocity.dy = 0
                            if heroMovedLeft || heroLooksLeft{
                                hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
                            }
                            else if heroLooksRight || heroLooksRight{
                                hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
                            }
//                            isJumping = true
                        }
                    case .transformed2:
                        Character.shared.characterAnimationSkill(characterTexture: heroBantPushTextures, hero: hero, skill: Character.shared.bantengAnimationName)
                        
                        for index in 0...4 {
                            boxDorong[index].physicsBody?.isDynamic = true
                        }
                    }
                }
                if node.name == "keluarMiniGames" {
                    self.isPaused = false
                    backgroundMiniGames.isHidden = true
                    connectVirtualController()
                    hero.isHidden = false
                    //blackNode.isHidden = true
                }
                
                if node.name == "lanjutWin"{
                    virtualController = nil
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "CardPerStageScene") {
                            let transition = SKTransition.fade(withDuration: 0.5)
                            scene.scaleMode = .resizeFill
                            view.presentScene(scene, transition: transition)
                            SoundManager.shared.stopAlarmSound()
                            SoundManager.shared.stopSpyMusic()
                        }
                    }
                }
                
                if node.name == "ulangiLose"{
                    virtualController = nil
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "StageTwo") {
                            let transition = SKTransition.fade(withDuration: 0.5)
                            scene.scaleMode = .resizeFill
                            view.presentScene(scene, transition: transition)
                            SoundManager.shared.stopAlarmSound()
                        }
                    }
                }
                
                if node.name == "keluarLose" {
                    virtualController = nil
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "CardPerStageScene") {
                            let transition = SKTransition.fade(withDuration: 0.5)
                            scene.scaleMode = .resizeFill
                            view.presentScene(scene, transition: transition)
                            SoundManager.shared.stopAlarmSound()
                            SoundManager.shared.stopSpyMusic()
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
                        SoundManager.shared.stopSpyMusic()
                        UserDefaults.standard.set(false, forKey: "SoundActive")
                    }
                    else{
                        SoundManager.shared.playSpyMusic()
                        UserDefaults.standard.set(true, forKey: "SoundActive")
                    }
                    
                }
                
                if node.name == "vibrateCheck" {
                    isVibrateEnabled.toggle()
                    vibrateCheck.texture = isVibrateEnabled ? SKTexture(imageNamed: "checked") : SKTexture(imageNamed: "unchecked")
                }
                
                for index in 0...3 {
                    if node == redSwitch[index] {
                        if !isSwitchTapped[index] {
                            let newSwitchTexure = SKTexture(imageNamed: "newGreenSwitch")
                            redSwitch[index].texture = newSwitchTexure
                            nodeClicked += 1
                            isSwitchTapped[index] = true
                            
                            if nodeClicked == 4 {
                                miniGamesCompleted()
                            }
                            
                        } else if isSwitchTapped[index] {
                            let newSwitchTexure = SKTexture(imageNamed: "newRedSwitch")
                            redSwitch[index].texture = newSwitchTexure
                            nodeClicked -= 1
                            isSwitchTapped[index] = false
                            if nodeClicked == -4 {
                                secondMiniGames()
                            }
                        }
                    }
                }
            }
        }
    }
    //Mini games
    func nodeWithBitMask(bitMask: UInt32) -> SKNode? {
        for node in self.children {
            if node.physicsBody?.categoryBitMask == bitMask {
                return node
            }
        }
        return nil
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "buttonSkill" {
                    //print( "Berhasil nekan")
                    switch heroState {
                    case .normal:
                        hero.removeAction(forKey: "heroAmkaMachAnimation")
                        isJumping = false
                    case .transformed:
                        isSpeedActive = false
                        isJumping = false
                    case .transformed1:
                        if !isJumping{
                            Character.shared.characterAnimationSkill(characterTexture: heroHizJumpTextures, hero: hero, skill: Character.shared.hizbullahAnimationName)
                            hero.physicsBody?.velocity.dy = 0
                            hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                            //isJumping = true
                        }
                    case .transformed2:
                        hero.removeAction(forKey: "heroBantPushAnimation")
                        for index in 0...4 {
                            boxDorong[index].physicsBody?.isDynamic = false
                        }
                    }
                }
                
                if node.name == hero.name {
                    switch heroState {
                    case .normal:
                        // Change the hero to a new state
                        let newHeroTexture = SKTexture(imageNamed: "heroAmr")
                        hero.texture = newHeroTexture
                        heroFrames = createHeroFrames(textureAtlasName: "heroAmrWalkAnimation")
                        let newSkillNodeTexture = SKTexture(imageNamed: "buttonRun")
                        skillNode.texture = newSkillNodeTexture
                        isHeroChanged = true
                        heroState = .transformed
                        
                    case .transformed:
                        // Change the hero to a new state
                        let newHeroTexture1 = SKTexture(imageNamed: "heroHiz")
                        hero.texture = newHeroTexture1
                        heroFrames = createHeroFrames(textureAtlasName: "heroHizWalkAnimation")
                        let newSkillNodeTexture = SKTexture(imageNamed: "buttonJump")
                        skillNode.texture = newSkillNodeTexture
                        isHeroChanged = true
                        heroState = .transformed1
                        //HERO BANTENG
                    case .transformed1:
                        // Change the hero to a new state
                        let newHeroTexture1 = SKTexture(imageNamed: "heroBantIdle0")
                        hero.texture = newHeroTexture1
                        heroFrames = createHeroFrames(textureAtlasName: "heroBantWalkAnimation")
                        let newSkillNodeTexture = SKTexture(imageNamed: "buttonPush")
                        skillNode.texture = newSkillNodeTexture
                        isHeroChanged = true
                        heroState = .transformed2
                        
                    case .transformed2:
                        // Change the hero back to its original state
                        hero.texture = heroTexture
                        if putusListrik{
                            let newSkillNodeTexture = SKTexture(imageNamed: "buttonTech")
                            skillNode.texture = newSkillNodeTexture
                        } else {
                            let newSkillNodeTexture = SKTexture(imageNamed: "buttonTech1")
                            skillNode.texture = newSkillNodeTexture
                        }
                        heroFrames = createHeroFrames(textureAtlasName: "heroAmkaWalk")
                        isHeroChanged = false
                        heroState = .normal
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        heroposX = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        //print(isJumping)
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
        let rightBoundary: CGFloat = 5680
        let upperBoundary: CGFloat = 400
        
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
        matiLampu?.position.x = (camera?.position.x)!
        cahaya.position.x = hero.position.x
        cahaya.position.y = hero.position.y
        //blackNode.position.x = hero.position.x
        
        if lives <= 0 {
            self.isPaused = true
            backgroundLose.isHidden = false
            SoundManager.shared.stopSpyMusic()
        }
    }
    
    func connectVirtualController() {
        
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
        for i in 0..<textureAtlas.textureNames.count {
            let textureName = prefix + String(i)
            frames.append(textureAtlas.textureNamed(textureName))
        }
        return frames
    }
    
    func addHero() {
        hero = childNode(withName: "hero") as! SKSpriteNode
        let heroSize = hero.size
        let smallerSize = CGSize(width: heroSize.width * 0.7, height: heroSize.height * 0.8)
        hero.physicsBody = SKPhysicsBody(rectangleOf: smallerSize)
        //hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.categoryBitMask = bitMask.hero.rawValue
        hero.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.box.rawValue | bitMask.duri.rawValue | bitMask.boxdorong.rawValue
        hero.physicsBody?.collisionBitMask = bitMask.ground.rawValue | bitMask.box.rawValue | bitMask.duri.rawValue | bitMask.boxdorong.rawValue
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.allowsRotation = false
    }
    
    func addGround() {
        for index in 1...8 {
            ground = childNode(withName: "ground\(index)") as! SKSpriteNode
            
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.categoryBitMask = bitMask.ground.rawValue
            ground.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
            ground.physicsBody?.collisionBitMask = bitMask.hero.rawValue
            ground.physicsBody?.isDynamic = false
        }
    }
    
    func addSkillNode() {
        skillNode.position = CGPoint(x: (cameraNode?.position.x)! - 140, y: frame.minY - 140)
        skillNode.size = CGSize(width: frame.width / 8.55, height: frame.height / 3.875)
        skillNode.zPosition = 50
        cameraNode?.addChild(skillNode)
    }
    
    //Mini games
    func addTuasLampuLightSituation() {
        tuasLampu = childNode(withName: "tuas") as! SKSpriteNode
        
        tuasLampu.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 50, height: 300))
        tuasLampu.physicsBody?.categoryBitMask = bitMask.tuas.rawValue
        tuasLampu.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        tuasLampu.physicsBody?.allowsRotation = false
        tuasLampu.physicsBody?.isDynamic = false
        
        tuasLampu.name = "tuasLampu"
    }
    
    func addTuasLampuLight2Situation() {
        tuasLampu2 = childNode(withName: "tuas2") as! SKSpriteNode
        
        tuasLampu2.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 50, height: 300))
        tuasLampu2.physicsBody?.categoryBitMask = bitMask.tuas2.rawValue
        tuasLampu2.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        tuasLampu2.physicsBody?.allowsRotation = false
        tuasLampu2.physicsBody?.isDynamic = false
        
        tuasLampu2.name = "tuasLampu2"
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
    
    func addBoxSenjataWinSituation() {
        boxSenjata = childNode(withName: "boxSenjata") as! SKSpriteNode
        
        boxSenjata.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 10, height: 10))  //berubah
        boxSenjata.physicsBody?.categoryBitMask = bitMask.boxSenjata.rawValue
        boxSenjata.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
        boxSenjata.physicsBody?.allowsRotation = false
        boxSenjata.physicsBody?.isDynamic = false
        boxSenjata.name = "boxSenjata"
    }
    
    func addTrap() {
        for index in 1...6 {
            trap[index] = childNode(withName: "trap\(index)") as! SKSpriteNode
            trap[index].physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 20, height: 20))
            trap[index].physicsBody?.categoryBitMask = bitMask.trapSituation.rawValue
            trap[index].physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
            trap[index].physicsBody?.allowsRotation = false
            trap[index].physicsBody?.isDynamic = false
            trap[index].name = "trap\(index)"
        }
    }
    
    func addbuttonObstacle() {
        for index in 1...4 {
            buttonObstacle = childNode(withName: "buttonObstacle\(index)") as! SKSpriteNode
            
            buttonObstacle.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 20, height: 40))
            buttonObstacle.physicsBody?.categoryBitMask = bitMask.buttonObstacle.rawValue
            buttonObstacle.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
            buttonObstacle.physicsBody?.allowsRotation = false
            buttonObstacle.physicsBody?.isDynamic = false
            
            buttonObstacle.name = "buttonObstacle"
        }
    }
    
    //    func addKey() {
    //        key = childNode(withName: "keyOne") as! SKSpriteNode
    //        key.position = boxdorong.position
    //        let keySize = key.size
    //        let keySmall = CGSize(width: keySize.width * 0.7, height: keySize.height)
    //        key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
    //        key.physicsBody?.isDynamic = false
    //        key.physicsBody?.affectedByGravity = false
    //        key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
    //        key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
    //        key.physicsBody?.allowsRotation = false
    //        key.name = "keyOne"
    //    }
    
    func addKey(){
        for index in 1...5 {
            key = childNode(withName: "key\(index)") as! SKSpriteNode
            
            let keySize = key.size
            let keySmall = CGSize(width: keySize.width * 0.5, height: keySize.height * 0.5)
            key.physicsBody = SKPhysicsBody.init(rectangleOf: keySmall)
            key.physicsBody?.isDynamic = false
            key.physicsBody?.affectedByGravity = false
            key.physicsBody?.categoryBitMask = bitMask.keyCategory.rawValue
            key.physicsBody?.contactTestBitMask = bitMask.ground.rawValue | bitMask.hero.rawValue
            key.physicsBody?.allowsRotation = false
            key.name = "key\(index)"
        }
    }
    
    //    func addLampuBangunan(){
    //        for index in 1...15 {
    //            lampu = childNode(withName: "lampu\(index)") as! SKSpriteNode
    //            lampu.isHidden = true
    //            lampu.name = "lampu\(index)"
    //        }
    //    }
    
    func addBoxDorong() {
        for index in 0...4 {
            boxDorong[index] = (childNode(withName: "boxdorong\(index + 1)") as? SKSpriteNode)!
            boxDorong[index].physicsBody = SKPhysicsBody(circleOfRadius: max(boxDorong[index].size.width / 1.5, boxDorong[index].size.height / 2))
            boxDorong[index].physicsBody?.isDynamic = false
            boxDorong[index].physicsBody?.affectedByGravity = true
            boxDorong[index].physicsBody?.allowsRotation = false
            boxDorong[index].physicsBody?.categoryBitMask = bitMask.boxdorong.rawValue
        }
    }
    
    func heroWalkAnimation() {
        for i in 0..<textureAtlaas.textureNames.count {
            let textureNames = "heroAmkaWalk" + String(i)
            heroFrames.append(textureAtlaas.textureNamed(textureNames))
        }
    }
    
    func enemyJepangIdleAnimation() {
        for i in 0..<jepangEnemyAtlas.textureNames.count {
            let textureNames = "jepangAnimationIdle" + String(i)
            jepangEnemyFrames.append(jepangEnemyAtlas.textureNamed(textureNames))
        }
    }
    //ini disimpan dulu
    func variantIdleAnimation() {
        for i in 0..<variantAtlas.textureNames.count {
            let textureNames = "variant" + String(i)
            variantFrames.append(variantAtlas.textureNamed(textureNames))
        }
    }
    
    func addJepangEnemy() {
        jepangEnemy = childNode(withName: "jepangEnemy") as! SKSpriteNode
        jepangEnemy.physicsBody = SKPhysicsBody(rectangleOf: jepangEnemy.size)
        jepangEnemy.physicsBody?.categoryBitMask = bitMask.jepangEnemy.rawValue
        jepangEnemy.physicsBody?.contactTestBitMask = bitMask.jepangEnemy.rawValue | bitMask.hero.rawValue
        jepangEnemy.physicsBody?.isDynamic = false
        jepangEnemy.physicsBody?.allowsRotation = false
        jepangEnemy.isHidden = true
        
        let jepangEnemyAnimation = SKAction.animate(with: jepangEnemyFrames, timePerFrame: 1)
        let jepangEnemyAnimationRepeat = SKAction.repeatForever(jepangEnemyAnimation)
        let removeFromParentAction = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([jepangEnemyAnimationRepeat, removeFromParentAction])
        
        jepangEnemy.run(sequence)
    }
    
    
    func addTimerNode() {
        ellipse = SKShapeNode(ellipseOf: CGSize(width: size.width * 0.12, height: size.height * 0.19))
        ellipse.position = CGPoint(x: frame.minX, y: frame.minY)
        ellipse.fillColor = SKColor.clear
        ellipse.strokeColor = SKColor(red: 0.24, green: 0.22, blue: 0.22, alpha: 1.0)
        ellipse.lineWidth = 8.0
        ellipse.zPosition = 100
        ellipse.isHidden = true
        cameraNode?.addChild(ellipse)
        
        timerNode.zPosition = 100
        timerNode.position = CGPoint(x: frame.minX, y: frame.minY - 10)
        timerNode.fontSize = 40
        timerNode.fontColor = .white
        timerNode.isHidden = true
        ellipse.addChild(timerNode)
        time = 5
    }
    
    func addBackgroundMiniGames() {
        
        backgroundMiniGames = SKSpriteNode(imageNamed: "newBackGroundMiniGames")
        backgroundMiniGames.zPosition = 53
        
        backgroundMiniGames.position = CGPoint(x: frame.minX, y:frame.minY )
        backgroundMiniGames.isHidden = true
        cameraNode?.addChild(backgroundMiniGames)
        
        variant = SKSpriteNode(imageNamed: "variant")
        variant.zPosition = 55
        variant.position = CGPoint(x: backgroundMiniGames.frame.midX, y: backgroundMiniGames.frame.midY + 67)
        backgroundMiniGames.addChild(variant)
        
        //ini disimpan dulu
        //        let variantAnimation = SKAction.animate(with: variantFrames, timePerFrame: 0.5)
        //        let variantAnimationRepeat = SKAction.repeatForever(variantAnimation)
        //        let removeFromParentAction = SKAction.removeFromParent()
        //
        //        let sequence = SKAction.sequence([variantAnimationRepeat, removeFromParentAction])
        //
        //        variant.run(sequence)
        keluarMiniGames = SKSpriteNode(imageNamed: "buttonExitV2")
        keluarMiniGames.zPosition = 54
        keluarMiniGames.size = CGSize(width: keluarMiniGames.frame.width, height: keluarMiniGames.frame.height)
        keluarMiniGames.position = CGPoint(x: backgroundMiniGames.frame.maxX - 19, y: backgroundMiniGames.frame.maxY - 18)
        keluarMiniGames.name = "keluarMiniGames"
        backgroundMiniGames.addChild(keluarMiniGames)
        
        for index in 0...3 {
            if index == 0 {
                redSwitch[index] = SKSpriteNode(imageNamed: "newRedSwitch")
                redSwitch[index].zPosition = 53
                redSwitch[index].size = CGSize(width: redSwitch[index].size.width, height: redSwitch[index].size.height)
                redSwitch[index].position = CGPoint(x: backgroundMiniGames.frame.minX + 80, y: backgroundMiniGames.frame.minY + 95)
                redSwitch[index].name = "redSwitch\(index + 1)"
                backgroundMiniGames.addChild(redSwitch[index])
            } else {
                redSwitch[index] = SKSpriteNode(imageNamed: "newRedSwitch")
                redSwitch[index].zPosition = 53
                redSwitch[index].size = CGSize(width: redSwitch[index].size.width, height: redSwitch[index].size.height)
                redSwitch[index].position = CGPoint(x: redSwitch[index - 1].position.x + 80, y: backgroundMiniGames.frame.minY + 95)
                redSwitch[index].name = "redSwitch\(index + 1)"
                backgroundMiniGames.addChild(redSwitch[index])
            }
        }
        //blackNode = SKSpriteNode(color: .black, size: CGSize(width: frame.size.width * 3, height: frame.size.height * 3))
        //blackNode.zPosition = 10
        //blackNode.position = CGPoint(x: frame.midX, y: frame.midY)
        //blackNode.alpha = 0.6
        //blackNode.isHidden = true
        //addChild(blackNode)
    }
    
    func tileMapPhysicsBodyBox(map: SKTileMapNode) {
        
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
                    let smallerSize = CGSize(width: boxSize.width * 0.7, height: boxSize.height * 1.1)
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: smallerSize)
                    tileNode.physicsBody?.categoryBitMask = bitMask.box.rawValue
                    tileNode.physicsBody?.collisionBitMask = bitMask.hero.rawValue
                    tileNode.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
                    
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.zPosition = 1
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + startLocation.x, y: tileNode.position.y + startLocation.y)
                    
                    self.addChild(tileNode)
                }
            }
        }
    }
    
    func miniGamesCompleted() {
        backgroundMiniGames.isHidden = true
        connectVirtualController()
        hero.isHidden = false
        jepangEnemy.isHidden = false
        isJepangHidden = false
        
        turnOnTheLamp()
        Character.shared.characterAnimationSkill(characterTexture: heroAmkaMachTextures, hero: hero, skill: Character.shared.amkaAnimationName)
        self.isPaused = false
        nodeClicked = 0
    }
    
    func secondMiniGames() {
        backgroundMiniGames.isHidden = true
        connectVirtualController()
        hero.isHidden = false
        putusListrik = true
        matiLampu?.isHidden = false
        cahaya.zPosition = 0
        cahaya.isHidden = false
        cahayatuas.zPosition = 0
        cahayatuas.isHidden = false
        remang.isHidden = true
        lampu.zPosition = 49
        lampu.isHidden = true
        lampu1.zPosition = 49
        lampu1.isHidden = true
        lampu2.zPosition = 49
        lampu2.isHidden = true
        timerNode.isHidden = false
        redNode.isHidden = false
        ellipse.isHidden = false
        //blackNode.isHidden = true
        self.isPaused = false
        isJepangHidden = true
        jepangEnemy.isHidden = true
        backgroundOverlayGames.isHidden = true
    }
    
    func turnOnTheLamp() {
        putusListrik = true
        matiLampu?.isHidden = true
        cahaya.zPosition = 0
        cahaya.isHidden = true
        cahayatuas.zPosition = 0
        cahayatuas.isHidden = true
        remang.isHidden = false
        lampu.zPosition = 49
        lampu.isHidden = false
        lampu1.zPosition = 49
        lampu1.isHidden = false
        lampu2.zPosition = 49
        lampu2.isHidden = false
        backgroundOverlayGames.isHidden = true
    }
}

