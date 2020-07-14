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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var basket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var fruitCollection = ["apple", "banana", "grapefruit", "lemon", "lime", "orange", "peach", "pear", "strawberry"]
    let fruitCategory: UInt32 = 0x1 << 1
    let badFruitCategory: UInt32 = 0x1 << 1
    let basketCategory: UInt32 = 0x1 << 0
    var gameTimer: Timer!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var livesArray: [SKSpriteNode]!
    
    
    
    override func didMove(to view: SKView) {
        createBackground()
        createBasket()
        //createFruit()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.0)
        let timeInterval = 0.75
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addFruit), userInfo: nil, repeats: true)
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x: 70, y: self.frame.size.height - 70)
        scoreLabel.fontName = "Marker Felt Wide"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.yellow
        score = 0
        
        self.addChild(scoreLabel)
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
        basket.physicsBody = SKPhysicsBody(circleOfRadius: basket.size.width/2)
        basket.physicsBody?.isDynamic = false
        basket.physicsBody?.categoryBitMask = PhysicsCategory.Basket
        self.addChild(basket)
        
    }
    
    
    @objc func addFruit(){
        
        fruitCollection = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: fruitCollection) as! [String]
        
        let fruit = SKSpriteNode(imageNamed: fruitCollection[0])
        let randomFruit = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.width))
        let position = CGFloat(randomFruit.nextInt())
        fruit.position = CGPoint(x: position, y: self.frame.size.height + fruit.size.height)
        fruit.size = CGSize(width: 40, height: 40)
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width/2)
        fruit.physicsBody?.isDynamic = true
        fruit.physicsBody?.categoryBitMask = fruitCategory
        fruit.physicsBody?.collisionBitMask = 0
        
        fruit.physicsBody?.affectedByGravity = true
        fruit.physicsBody?.categoryBitMask = PhysicsCategory.Fruit
        fruit.physicsBody?.contactTestBitMask = PhysicsCategory.Basket
        fruit.physicsBody?.collisionBitMask = PhysicsCategory.Basket
        self.addChild(fruit)
    }
    
    @objc func createBadApple(){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Basket | PhysicsCategory.Fruit {
            self.score += 1
            let fruitCatch = SKAction.playSoundFileNamed("basketPop.mp3", waitForCompletion: false)
            self.run(fruitCatch)
            
            contact.bodyB.node?.removeFromParent()

        }
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
