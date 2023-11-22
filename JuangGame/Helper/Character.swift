//
//  Character.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 12/11/23.
//

import SpriteKit

class Character: SKScene {
    
    static let shared = Character()
    
    let bantengAnimationName = "heroBantPushAnimation"
    let hizbullahAnimationName = "heroHizJumpAnimation"
    let amkaAnimationName = "heroAmkaMachAnimation"
    
    func characterAnimationSkill(characterTexture: [SKTexture], hero: SKSpriteNode, skill: String) {
        let characterAnimation = SKAction.animate(with: characterTexture, timePerFrame: 0.1)
        hero.run(SKAction.repeatForever(characterAnimation), withKey: skill)
    }
}
