//
//  MissionTwoScene.swift
//  SemarangGame
//
//  Created by Rizky Dwi Hadisaputro on 13/11/23.
//

import SpriteKit

class MissionTwoScene: SKScene {
    
    private var background: SKSpriteNode!
    private var buttonNext: SKSpriteNode?
    private var buttonBack: SKSpriteNode?
    private var amka: SKSpriteNode?
    private var missionText: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        //background = childNode(withName: "background") as? SKSpriteNode
        //background?.size = self.size
        background = SKSpriteNode(imageNamed: "missiontwo")
        background.size = self.size
        background.zPosition = 1
        addChild(background)
        
        buttonNext = childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.zPosition = 7
        buttonNext?.name = "buttonNext"
        buttonNext?.size = CGSize(width: size.width * 0.08215962, height: size.height * 0.17811705)
        buttonNext?.position = CGPoint(x: size.width * 0.43309859, y: -size.height * 0.36641221)
        
        SoundManager.shared.stopCardPerSceneSound()
        
        buttonBack = childNode(withName: "buttonBack") as? SKSpriteNode
        buttonBack?.zPosition = 7
        buttonBack?.name = "buttonBack"
        buttonBack?.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        buttonBack?.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        
        amka = childNode(withName: "amka") as? SKSpriteNode
        amka?.position = CGPoint(x: -size.width * 0.36565728, y: -size.height * 0.06361323)
        
        missionText = childNode(withName: "missionText") as? SKSpriteNode
        missionText?.position = CGPoint(x: size.width * 0.00173709, y: -size.height * 0.06361323)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "buttonNext" {
                    
                    if let scene = SKScene(fileNamed: "StageTwo") {
                        let transition = SKTransition.fade(withDuration: 1)
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene, transition: transition)
                    }
                    
                }
                if node.name == "buttonBack" {
                    if let scene = SKScene(fileNamed: "CardPerStageScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        // Present the scene
                        view?.presentScene(scene)
                    }
                }
            }
        }
    }
    
}
