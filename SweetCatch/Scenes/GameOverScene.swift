//
//  GameOverScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/13/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class GameOverScene: SKScene {
    
    var gameOverLabel = SKLabelNode(text: "Game Over")
    let scoreLabel = SKLabelNode()
    let scoreLabelResult = SKLabelNode()
    var finalScore: Int!
    let highestScore = SKLabelNode(fontNamed: "American Typewriter")
    let highestScoreLabel = SKLabelNode(fontNamed: "American TypeWriter")
    let scoreKey = "scoreKey"
    public var backgroundMusicPlayer: AVAudioPlayer?

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
//        playBackgroundMusic("menuMusic.mp3")
        MyAudioPlayer.playFile(name: "menuMusic", type: "mp3")
    
    }
    
    public func playBackgroundMusic(_ filename: String) {
      let url = Bundle.main.url(forResource: "menuMusic.mp3", withExtension: nil)
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
    
    func createLabels(){
        scoreLabel.text = "Final Score"
        scoreLabel.fontName = "Marker Felt Wide"
        scoreLabel.fontColor = .yellow
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 275)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
        
        scoreLabelResult.text = "\(finalScore!)"
        scoreLabelResult.fontName = "Marker Felt Wide"
        scoreLabelResult.fontColor = .white
        scoreLabelResult.fontSize = 50
        scoreLabelResult.position = CGPoint(x: size.width / 2, y: size.height - 325)
        scoreLabelResult.zPosition = 3
        self.addChild(scoreLabelResult)
        
        highestScoreLabel.text = "Highest Score"
        highestScoreLabel.fontName = "CopperPlate"
        highestScoreLabel.fontColor = .green
        highestScoreLabel.zPosition = 3
        highestScoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        self.addChild(highestScoreLabel)
        
        
        addChild(gameOverLabel)
        gameOverLabel.fontSize = 80.0
        gameOverLabel.fontColor = .systemRed
        gameOverLabel.fontName = "Marker Felt Wide"
        gameOverLabel.zPosition = 3
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height - 225)
    }

        func createButton(){
            //Button
            let buttonTexture = SKTexture(imageNamed: "button")
            let buttonSelected = SKTexture(imageNamed: "button2")
            
            let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScene.buttonTap))
            button.setButtonLabel(title: "Play Again", font: "Marker Felt", fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 90)
            button.size = CGSize(width: 200, height: 200)
            button.zPosition = 4
            self.addChild(button)
            
            let button2 = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button2.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScene.buttonTap2))
            button2.setButtonLabel(title: "Main Menu", font: "Marker Felt", fontSize: 25)
            button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 230)
            button2.size = CGSize(width: 200, height: 200)
            button2.zPosition = 4
            self.addChild(button2)
        }

        @objc func buttonTap(){
            let gameScene = GameScene(size: (self.view?.bounds.size)!)
            //backgroundMusicPlayer!.stop()
            MyAudioPlayer.stopFile(name: "menuMusic", type: "mp3")
            gameScene.scaleMode = .aspectFill
            let crossFade = SKTransition.crossFade(withDuration: 0.75)
            if let spriteview = self.view{
                spriteview.presentScene(gameScene, transition: crossFade)
            }
        }
    
        @objc func buttonTap2(){
            let gameScene = MenuScene(size: (self.view?.bounds.size)!)
            //backgroundMusicPlayer!.stop()
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
            highestScore.text = "\(finalScore!)"
        }else{
            highestScore.text = "\(score)"
        }
        highestScore.fontColor = .white
        highestScore.fontSize = 30
        highestScore.position = CGPoint(x: size.width / 2, y: size.height - 75)
        highestScore.zPosition = 4
        self.addChild(highestScore)
    
    }
}
