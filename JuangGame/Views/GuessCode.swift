//
//  GuessCode.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/11/23.
//

import SpriteKit

class GuessCode: SKScene {
    
    private var redOne = SKSpriteNode()
    var isRedOneClicked = false
    var randomNodeOne = ""
    
    private var redTwo = SKSpriteNode()
    var isRedTwoClicked = false
    var randomNodeTwo = ""
    
    private var redThree = SKSpriteNode()
    var isRedThreeClicked = false
    
    private var redFour = SKSpriteNode()
    var isRedFourClicked = false
    
    let randomNameRed = ["redOne", "redTwo", "redThree", "redFour"].shuffled()
    
    
    var nodeClicked = 0
    
    override func didMove(to view: SKView) {
        addRedNode()
        
        print(randomNameRed)
        
        randomNodeOne = randomNameRed[0]
        randomNodeTwo = randomNameRed[1]
        
        print(randomNodeOne)
        print(randomNodeTwo)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                    if node == redOne {
                        if !isRedOneClicked && nodeClicked < 2 {
                            redOne.color = UIColor.green
                            isRedOneClicked = true
                            nodeClicked += 1
                            print(nodeClicked)
                        } else if isRedOneClicked {
                            redOne.color = UIColor.red
                            isRedOneClicked = false
                            nodeClicked -= 1
                            print(nodeClicked)
                        }
                    }
                    
                    if node == redTwo {
                        if !isRedTwoClicked && nodeClicked < 2 {
                            redTwo.color = UIColor.green
                            isRedTwoClicked = true
                            nodeClicked += 1
                            print(nodeClicked)
                        } else if isRedTwoClicked {
                            redTwo.color = UIColor.red
                            isRedTwoClicked = false
                            nodeClicked -= 1
                            print(nodeClicked)
                        }
                    }
                    
                    if node == redThree {
                        if !isRedThreeClicked && nodeClicked < 2 {
                            redThree.color = UIColor.green
                            isRedThreeClicked = true
                            nodeClicked += 1
                            print(nodeClicked)
                        } else if isRedThreeClicked {
                            redThree.color = UIColor.red
                            isRedThreeClicked = false
                            nodeClicked -= 1
                            print(nodeClicked)
                        }
                    }
                    
                    if node == redFour {
                        if !isRedFourClicked && nodeClicked < 2 {
                            redFour.color = UIColor.green
                            isRedFourClicked = true
                            nodeClicked += 1
                            print(nodeClicked)
                        } else if isRedFourClicked {
                            redFour.color = UIColor.red
                            isRedFourClicked = false
                            nodeClicked -= 1
                            print(nodeClicked)
                        }
                    }
                
                if (randomNodeOne == "redOne" && isRedOneClicked) && ((randomNodeTwo == "redTwo" && isRedTwoClicked) || (randomNodeTwo == "redThree" && isRedThreeClicked) || (randomNodeTwo == "redFour" && isRedFourClicked)) {
                    ifTheSituationTrue()
                } else if (randomNodeOne == "redTwo" && isRedTwoClicked) && ((randomNodeTwo == "redOne" && isRedOneClicked) || (randomNodeTwo == "redThree" && isRedThreeClicked) || (randomNodeTwo == "redFour" && isRedFourClicked)) {
                    
                    ifTheSituationTrue()
                    
                } else if (randomNodeOne == "redThree" && isRedThreeClicked) && ((randomNodeTwo == "redOne" && isRedOneClicked) || (randomNodeTwo == "redTwo" && isRedTwoClicked) || (randomNodeTwo == "redFour" && isRedFourClicked)) {
                    ifTheSituationTrue()
                    
                } else if (randomNodeOne == "redFour" && isRedFourClicked) && ((randomNodeTwo == "redOne" && isRedOneClicked) || (randomNodeTwo == "redTwo" && isRedTwoClicked) || (randomNodeTwo == "redThree" && isRedThreeClicked)) {
                    ifTheSituationTrue()
                }
            }
        }
    }
    
    func addRedNode() {
        redOne = (childNode(withName: "redOne") as! SKSpriteNode?)!
        redOne.name = "redOne"
        
        redTwo = (childNode(withName: "redTwo") as! SKSpriteNode?)!
        redTwo.name = "redOne"
        
        redThree = (childNode(withName: "redThree") as! SKSpriteNode?)!
        redThree.name = "redThree"
        
        redFour = (childNode(withName: "redFour") as! SKSpriteNode?)!
        redFour.name = "redFour"
    }
    
    func ifTheSituationTrue() {
        if let view = self.view {
            // Load the SKScene from 'GameOverScene.sks'
            if let scene = SKScene(fileNamed: "WinScene") {
                print("Win Scene")
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                print("Win Scene displayed")
            }
        }
    }
}
