//
//  CharacterScene.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 19/10/23.
//

import SpriteKit

class CharacterScene: SKScene {
    var buttonBack: SKSpriteNode?
    private var background: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        if let buttonBack = childNode(withName: "buttonBack") as? SKSpriteNode {
            buttonBack.name = "buttonBack"
            
            if let background = childNode(withName: "background") as? SKSpriteNode {
                background.size = self.size
                
                let buttonPositionInScene = convert(buttonBack.position, from: buttonBack)
                
                buttonBack.position = CGPoint(x: size.width * -0.44088146, y: size.height * 0.39440204)
            }
        }
        
        SoundManager.shared.stopCardPerSceneSound()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
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
