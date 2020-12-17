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
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var basket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var levelLabel: SKLabelNode!
    var fruitCollection = ["apple", "banana", "grapefruit", "lemon", "lime", "orange", "peach", "pear", "strawberry"]
    let fruitCategory: UInt32 = 0x1 << 1
    let badFruitCategory: UInt32 = 0x1 << 1
    let basketCategory: UInt32 = 0x1 << 0
    var gameTimer: Timer!
    var badGameTimer: Timer!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level: Int = 0 {
        didSet {
            levelLabel.text = "Level \(level)"
        }
    }
    var timeInterval = 0.95
    var timerInterval2 = 0.75
    
    var livesArray: [SKSpriteNode]!
    
    public var backgroundMusicPlayer: AVAudioPlayer?
    
    
    override func didMove(to view: SKView) {
        createBackground()
        createBasket()
        //createFruit()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addFruit), userInfo: nil, repeats: true)
        badGameTimer = Timer.scheduledTimer(timeInterval: timerInterval2, target: self, selector: #selector(createBadApple), userInfo: nil, repeats: true)
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x: 70, y: self.frame.size.height - 70)
        scoreLabel.fontName = "Marker Felt Wide"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.yellow
        score = 0
        self.addChild(scoreLabel)
        
        levelLabel = SKLabelNode(text: "Level \(level)")
        levelLabel.position = CGPoint(x: frame.midX, y: self.frame.size.height - 110)
        levelLabel.fontSize = 42
        levelLabel.fontColor = UIColor.purple
        levelLabel.fontName = "Marker Felt Wide"
        level = 1
        
        self.addChild(levelLabel)
//        let backgroundMusic = SKAction.playSoundFileNamed("backgroundMusic.mp3", waitForCompletion: false)
//         self.run(backgroundMusic)
        
//        if let musicURL = Bundle.main.url(forResource: "backgroundMusic.mp3", withExtension: "Sounds"){
//            backgroundMusic = SKAudioNode(url: musicURL)
//            addChild(backgroundMusic)
//        }
        playBackgroundMusic("backgroundMusic.mp3")
        addLives()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if self.score == 10 {
            timeInterval = 1
            timerInterval2 = 0.75
            level = 2
        }else if self.score == 30 {
            timeInterval = 0.5
            timerInterval2 = 0.75
            level = 3
        }else if self.score == 50 {
            timeInterval = 0.5
            timerInterval2 = 0.5
            level = 4
        }else if self.score == 70 {
            timeInterval = 0.5
            timerInterval2 = 0.3
            level = 5
        }else if self.score == 100 {
            timeInterval = 0.3
            timerInterval2 = 0.3
            level = 6
        }else if self.score == 150 {
            timeInterval = 0.2
            timerInterval2 = 0.2
            level = 7
        }else if self.score == 200 {
            timeInterval = 0.2
            timerInterval2 = 0.4
            level = 8
        }else if self.score == 300 {
            timeInterval = 1
            timerInterval2 = 0.2
            level = 9
        }else if self.score >= 400 {
            timeInterval = 0.2
            timerInterval2 = 0.2
            level = 10
        }
    }
    
    @objc func createBadApple(){
        let badFruit = BadFruit()
        let randomFruit = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.width))
        let position = CGFloat(randomFruit.nextInt())
        
        badFruit.position = CGPoint(x: position, y: self.frame.size.height + badFruit.size.height)
        self.addChild(badFruit)
    }
    
    @objc func addFruit(){
        let fruit = Fruit()
        let randomFruit = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.width))
        let position = CGFloat(randomFruit.nextInt())
        
        fruit.position = CGPoint(x: position, y: self.frame.size.height + fruit.size.height)
        self.addChild(fruit)
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
        basket.size = CGSize(width: 90, height: 85)
        basket.position = CGPoint(x: 150, y: 60)
        basket.physicsBody = SKPhysicsBody(circleOfRadius: basket.size.width/2)
        basket.physicsBody?.isDynamic = false
        basket.physicsBody?.categoryBitMask = PhysicsCategory.Basket
        self.addChild(basket)
        
    }
    
    func addLives(){
        livesArray = [SKSpriteNode]()
        
        for live in 1...3 {
            let liveNode = SKSpriteNode(imageNamed: "basket")
            liveNode.size = CGSize(width: 25, height: 25)
            liveNode.position = CGPoint(x: self.frame.size.width - CGFloat(4 - live) * liveNode.size.width, y: self.frame.size.height - 70)
            self.addChild(liveNode)
            livesArray.append(liveNode)
        }
    }
    
    public func playBackgroundMusic(_ filename: String) {
      let url = Bundle.main.url(forResource: "backgroundMusic.mp3", withExtension: nil)
      if (url == nil) {
        print("Could not find file: \(filename)")
        return
      }

      var error: NSError? = nil
      do {
        backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url!)
      } catch let error1 as NSError {
        error = error1
        backgroundMusicPlayer = nil
      }
      if let player = backgroundMusicPlayer {
        player.numberOfLoops = -1
        player.prepareToPlay()
        player.play()
      } else {
        print("Could not create audio player: \(error!)")
      }
    }
    
    
//    @objc func addFruit(){
//
//        fruitCollection = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: fruitCollection) as! [String]
//
//        let fruit = SKSpriteNode(imageNamed: fruitCollection[0])
//        let randomFruit = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.width))
//        let position = CGFloat(randomFruit.nextInt())
//
//        fruit.position = CGPoint(x: position, y: self.frame.size.height + fruit.size.height)
//        fruit.size = CGSize(width: 40, height: 40)
//        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width/2)
//        fruit.physicsBody?.isDynamic = true
//        fruit.physicsBody?.categoryBitMask = fruitCategory
//        fruit.physicsBody?.collisionBitMask = 0
//
//        fruit.physicsBody?.affectedByGravity = true
//        fruit.physicsBody?.categoryBitMask = PhysicsCategory.Fruit
//        fruit.physicsBody?.contactTestBitMask = PhysicsCategory.Basket
//        fruit.physicsBody?.collisionBitMask = PhysicsCategory.Basket
//        self.addChild(fruit)
//    }

    
//    @objc func createBadApple(){
//        let badFruit = SKSpriteNode(imageNamed: "rottenFruit")
//        let randomFruit = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.width))
//        let position = CGFloat(randomFruit.nextInt())
//
//        badFruit.position = CGPoint(x: position, y: self.frame.size.height + badFruit.size.height)
//        badFruit.size = CGSize(width: 50, height: 50)
//        badFruit.physicsBody = SKPhysicsBody(circleOfRadius: badFruit.size.width/2)
//        badFruit.physicsBody?.isDynamic = true
//        badFruit.physicsBody?.categoryBitMask = PhysicsCategory.BadFruit
//        badFruit.physicsBody?.contactTestBitMask = PhysicsCategory.Basket
//        badFruit.physicsBody?.collisionBitMask = PhysicsCategory.Basket
//        self.addChild(badFruit)
//    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {

        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Basket | PhysicsCategory.Fruit {
            self.score += 1
            let fruitCatch = SKAction.playSoundFileNamed("basketPop.mp3", waitForCompletion: false)
            self.run(fruitCatch)
            
            contact.bodyB.node?.removeFromParent()

        }else if collision == PhysicsCategory.Basket | PhysicsCategory.BadFruit{
            
            let badFruitCatch = SKAction.playSoundFileNamed("badFruitSound.mp3", waitForCompletion: false)
            self.run(badFruitCatch)
            
            if self.livesArray.count > 0 {
                let liveNode = self.livesArray.first
                liveNode!.removeFromParent()
                self.livesArray.removeFirst()
                contact.bodyB.node?.removeFromParent()
                
                if self.livesArray.count == 0 {
                    //Game Over Transistion screen
                    //backgroundMusic.run(SKAction.stop())
                    backgroundMusicPlayer!.stop()
                    let transition = SKTransition.crossFade(withDuration: 0.2)
                    let gameOver = GameOverScene(size: (self.view?.bounds.size)!)
                    gameOver.finalScore = self.score
                    self.view?.presentScene(gameOver, transition: transition)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            basket.position = CGPoint(x: location.x, y: 50)
        }
    }

}
