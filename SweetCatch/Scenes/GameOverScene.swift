//
//  GameOverScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/13/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var gameOverLabel = SKLabelNode(text: "Game Over")
    let scoreLabel = SKLabelNode()
    var finalScore: Int!
    let highestScore = SKLabelNode(fontNamed: "American Typewriter")
    let scoreKey = "scoreKey"

    override init(size: CGSize) {
        // do initial configuration work here
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    override func didMove(to view: SKView) {
        let soundOver = SKAction.playSoundFileNamed("gameOverSound.mp3", waitForCompletion: false)
        self.run(soundOver)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = UIScreen.main.bounds.size
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        background.zPosition = 2
        self.addChild(background)
        createButton()
        createLabels()
        setHighestScore()
    
    }
    
    func createLabels(){
        scoreLabel.text = "Final Score: \(finalScore!)"
        scoreLabel.fontName = "Marker Felt Wide"
        scoreLabel.fontColor = .yellow
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: size.width / 2, y: 400)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
        
        addChild(gameOverLabel)
        gameOverLabel.fontSize = 32.0
        gameOverLabel.color = SKColor.white
        gameOverLabel.fontName = "Marker Felt Wide"
        gameOverLabel.zPosition = 3
        gameOverLabel.position = CGPoint(x: size.width / 2, y: 500)
    }

        func createButton(){
            //Button
            let buttonTexture = SKTexture(imageNamed: "button")
            let buttonSelected = SKTexture(imageNamed: "button2")
            
            let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScene.buttonTap))
            button.setButtonLabel(title: "Play Again", font: "Marker Felt", fontSize: 20)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 70)
            button.size = CGSize(width: 300, height: 100)
            button.zPosition = 4
            self.addChild(button)
        }
        
        @objc func buttonTap(){
            let gameScene = GameScene(size: (self.view?.bounds.size)!)

            gameScene.scaleMode = .aspectFill
            let crossFade = SKTransition.crossFade(withDuration: 0.75)
            if let spriteview = self.view{
                spriteview.presentScene(gameScene, transition: crossFade)
            }
        }
    
    func setHighestScore(){
        let score = UserDefaults.standard.integer(forKey: "score")
        if finalScore > score{
            UserDefaults.standard.set(finalScore, forKey: "score")
            highestScore.text = "Highest Score: \(finalScore!)"
        }else{
            highestScore.text = "Highest Score: \(score)"
        }
        highestScore.fontColor = .orange
        highestScore.fontSize = 30
        highestScore.position = CGPoint(x: size.width / 2, y: 600)
        highestScore.zPosition = 4
        self.addChild(highestScore)
    
    }
}
