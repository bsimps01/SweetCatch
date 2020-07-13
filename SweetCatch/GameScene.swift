//
//  GameScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/11/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    var basket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var livesArray: [SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        createBackground()
        createBasket()
    }
    
    func createBackground(){
        let background = SKSpriteNode(imageNamed: "background")
        background.zPosition = -1
        background.size = UIScreen.main.bounds.size
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(background)
    }
    
    func createBasket(){
        basket = SKSpriteNode(imageNamed: "basket")
        basket.size = CGSize(width: 75, height: 70)
        basket.position = CGPoint(x: 150, y: 50)
        self.addChild(basket)
        
    }
    
    
    func createFruit(){
        
    }
    
    func createDebris(){
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            basket.position = CGPoint(x: location.x, y: 50)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
