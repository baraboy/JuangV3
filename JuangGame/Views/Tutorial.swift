import SpriteKit
import Foundation

class Tutorial: SKScene {
    
    var tutorial1: SKSpriteNode?
    var tutorial2: SKSpriteNode?
    var tutorial3: SKSpriteNode?
    var tutorial4: SKSpriteNode?
    var currentNode: SKSpriteNode?
    var touchCount = 0
    
    override func didMove(to view: SKView) {
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isHaveReadTutorial")

        
        tutorial1 = self.childNode(withName: "tutorial1") as? SKSpriteNode
        tutorial2 = self.childNode(withName: "tutorial2") as? SKSpriteNode
        tutorial3 = self.childNode(withName: "tutorial3") as? SKSpriteNode
        tutorial4 = self.childNode(withName: "tutorial4") as? SKSpriteNode
        
        tutorial1?.alpha = 1
        tutorial2?.alpha = 0
        tutorial3?.alpha = 0
        tutorial4?.alpha = 0
        
        currentNode = tutorial1
        
        let wait = SKAction.wait(forDuration: 2)
        let appear = SKAction.run {
            self.tutorial2?.alpha = 1
            self.currentNode = self.tutorial2
        }
        
        let sequence = SKAction.sequence([wait, appear])
        self.run(sequence)
        
        if let background = childNode(withName: "tutorial1") as? SKSpriteNode {
            background.size = self.size
        }
        if let background = childNode(withName: "tutorial2") as? SKSpriteNode {
            background.size = self.size
        }
        if let background = childNode(withName: "tutorial3") as? SKSpriteNode {
            background.size = self.size
        }
        if let background = childNode(withName: "tutorial4") as? SKSpriteNode {
            background.size = self.size
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let appear = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 0.5)
        
        let sequenceIn = SKAction.sequence([wait, appear])
        
        if currentNode === tutorial2 {
            currentNode = tutorial3
        } else if currentNode === tutorial3 {
            currentNode = tutorial4
        } else if currentNode === tutorial4 {
            if let view = self.view {
                // Load the SKScene from 'GameOverScene.sks'
                if let scene = SKScene(fileNamed: "StageOne") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    // Present the scene
                    view.presentScene(scene)
                }
            }
        }
        
        currentNode?.run(sequenceIn)
    }
}
