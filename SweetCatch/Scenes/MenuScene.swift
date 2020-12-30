//
//  MenuScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 8/6/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class MenuScene: SKScene {
    
    var title = SKSpriteNode(imageNamed: "SweetCatchLogo")
    
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
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = UIScreen.main.bounds.size
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        background.zPosition = 2
        self.addChild(background)
        createButton()
        createLabels()
        //playBackgroundMusic("menuMusic.mp3")
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
        addChild(title)
        title.zPosition = 3
        title.size = CGSize(width: 350, height: 275)
        title.position = CGPoint(x: size.width / 2, y: size.height - 175)
    }

        func createButton(){
            //Button
            let buttonTexture = SKTexture(imageNamed: "button")
            let buttonSelected = SKTexture(imageNamed: "button2")
            
            let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(MenuScene.buttonTap))
            button.setButtonLabel(title: "Start Game", font: "Marker Felt", fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
            button.size = CGSize(width: 200, height: 200)
            button.zPosition = 4
            self.addChild(button)
            
            let button2 = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button2.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(MenuScene.buttonTap2))
            button2.setButtonLabel(title: "How to Play", font: "Marker Felt", fontSize: 25)
            button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
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
            let infoScene = InfoScene(size: (self.view?.bounds.size)!)
        
            infoScene.scaleMode = .aspectFill
            let crossFade = SKTransition.crossFade(withDuration: 0.75)
            if let spriteview = self.view{
                spriteview.presentScene(infoScene, transition: crossFade)
            }
        }
    
}
