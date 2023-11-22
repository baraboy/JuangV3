//
//  MissionOneScene.swift
//  SemarangGame
//
//  Created by Ayla Ainayyah M on 23/10/23.
//

import SpriteKit

class MissionOneScene: SKScene {
    private var button: SKSpriteNode?
    private var label: SKSpriteNode?
    private var movingObjects: [SKSpriteNode] = []
    var backButton: SKSpriteNode?
    private var background: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        button = childNode(withName: "button") as? SKSpriteNode
        button?.name = "button"
        //button?.size = CGSize(width: 60, height: 60)
        //button?.position = CGPoint(x: frame.midX + 369, y: frame.midY - 144)
        button?.size = CGSize(width: size.width * 0.08215962, height: size.height * 0.17811705)
        button?.position = CGPoint(x: size.width * 0.43309859, y: -size.height * 0.36641221)
        SoundManager.shared.stopCardPerSceneSound()
        
        backButton = childNode(withName: "backButton") as? SKSpriteNode
        backButton?.name = "backButton"
        //backButton?.size = CGSize(width: 50, height: 50)
        //backButton?.position = CGPoint(x: frame.midX - 350, y: frame.midY + 151.5)
        backButton?.size = CGSize(width: size.width * 0.07042254, height: size.height * 0.15267176)
        backButton?.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
        
        if let background = childNode(withName: "background") as? SKSpriteNode {
            background.size = self.size
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "button" {
                    if UserDefaults.standard.bool(forKey: "isHaveReadTutorial") {
                        if let scene = SKScene(fileNamed: "StageOne") {
                            let transition = SKTransition.fade(withDuration: 1)
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .resizeFill
                            // Present the scene
                            view?.presentScene(scene, transition: transition)
                        }
                    }
                    else{
                        if let scene = SKScene(fileNamed: "TutorialScene") {
                            let transition = SKTransition.fade(withDuration: 1)
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .resizeFill
                            // Present the scene
                            view?.presentScene(scene, transition: transition)
                        }
                    }
                }
                if node.name == "backButton" {
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
