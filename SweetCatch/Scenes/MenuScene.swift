//
//  MenuScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 8/6/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var title = SKLabelNode(text: "Sweet Catch")

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
    
    }
    
    func createLabels(){
        addChild(title)
        title.fontSize = 48.0
        title.fontColor = SKColor.orange
        title.fontName = "Marker Felt Wide"
        title.zPosition = 3
        title.position = CGPoint(x: size.width / 2, y: 500)
    }

        func createButton(){
            //Button
            let buttonTexture = SKTexture(imageNamed: "button")
            let buttonSelected = SKTexture(imageNamed: "button2")
            
            let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(MenuScene.buttonTap))
            button.setButtonLabel(title: "Start Game", font: "Marker Felt", fontSize: 20)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            button.size = CGSize(width: 300, height: 100)
            button.zPosition = 4
            self.addChild(button)
            
            let button2 = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button2.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(MenuScene.buttonTap2))
            button2.setButtonLabel(title: "How to Play", font: "Marker Felt", fontSize: 20)
            button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 110)
            button2.size = CGSize(width: 300, height: 100)
            button2.zPosition = 4
            self.addChild(button2)
        }
        
        @objc func buttonTap(){
            let gameScene = GameScene(size: (self.view?.bounds.size)!)

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
