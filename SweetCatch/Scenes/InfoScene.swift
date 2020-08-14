//
//  InfoScene.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 8/6/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class InfoScene: SKScene {
    
    var title = SKLabelNode(text: "Sweet Catch")
    var badFruit = SKSpriteNode(imageNamed: "rottenFruit")
    var lineOne: SKLabelNode!
    var lineTwo: SKLabelNode!
    var lineThree: SKLabelNode!
    var orange = SKSpriteNode(imageNamed: "orange")
    var apple = SKSpriteNode(imageNamed: "apple")
    var banana = SKSpriteNode(imageNamed: "banana")
    var lime = SKSpriteNode(imageNamed: "lime")
    var strawberry = SKSpriteNode(imageNamed: "strawberry")
    var basket = SKSpriteNode(imageNamed: "basket")

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
        title.fontColor = SKColor.white
        title.fontName = "Marker Felt Wide"
        title.zPosition = 3
        title.position = CGPoint(x: size.width / 2, y: 600)
        
        lineOne = SKLabelNode(text: "-Catch all the different kinds of fruits to earn points")
        addChild(lineOne)
        lineOne.fontSize = 16.0
        lineOne.fontColor = SKColor.yellow
        lineOne.fontName = "Marker Felt"
        lineOne.zPosition = 3
        lineOne.position = CGPoint(x: size.width / 2, y: 575)
        
        lineTwo = SKLabelNode(text: "-Use your finger to drag the basket side to side")
        addChild(lineTwo)
        lineTwo.fontSize = 16.0
        lineTwo.fontColor = SKColor.yellow
        lineTwo.fontName = "Marker Felt"
        lineTwo.zPosition = 3
        lineTwo.position = CGPoint(x: size.width / 2, y: 525)
        
        lineThree = SKLabelNode(text: "-Avoid the bad fruit to not lose a life")
        addChild(lineThree)
        lineThree.fontSize = 16.0
        lineThree.fontColor = SKColor.yellow
        lineThree.fontName = "Marker Felt"
        lineThree.zPosition = 3
        lineThree.position = CGPoint(x: size.width / 2, y: 475)
        
        orange.size = CGSize(width: 40, height: 40)
        orange.zPosition = 3
        orange.position = CGPoint(x: size.width / 2 - 40, y: 560)
        addChild(orange)
        
        apple.size = CGSize(width: 40, height: 40)
        apple.zPosition = 3
        apple.position = CGPoint(x: size.width / 2, y: 560)
        addChild(apple)
        
        banana.size = CGSize(width: 40, height: 40)
        banana.zPosition = 3
        banana.position = CGPoint(x: size.width / 2 + 40, y: 560)
        addChild(banana)
        
        lime.size = CGSize(width: 40, height: 40)
        lime.zPosition = 3
        lime.position = CGPoint(x: size.width / 2 + 80, y: 560)
        addChild(lime)
        
        strawberry.size = CGSize(width: 40, height: 40)
        strawberry.zPosition = 3
        strawberry.position = CGPoint(x: size.width / 2 - 80, y: 560)
        addChild(strawberry)
        
        basket.size = CGSize(width: 30, height: 30)
        basket.zPosition = 3
        basket.position = CGPoint(x: size.width / 2, y: 505)
        addChild(basket)
        
        badFruit.size = CGSize(width: 40, height: 40)
        badFruit.zPosition = 3
        badFruit.position = CGPoint(x: size.width / 2, y: 450)
        addChild(badFruit)
        
        
        
        
    }

        func createButton(){
            //Button
            let buttonTexture = SKTexture(imageNamed: "button")
            let buttonSelected = SKTexture(imageNamed: "button2")
            
            let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonSelected, disabledTexture: buttonTexture)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(MenuScene.buttonTap))
            button.setButtonLabel(title: "Back", font: "Marker Felt", fontSize: 20)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            button.size = CGSize(width: 300, height: 100)
            button.zPosition = 4
            self.addChild(button)
            
        }
        
        @objc func buttonTap(){
            let gameScene = MenuScene(size: (self.view?.bounds.size)!)

            gameScene.scaleMode = .aspectFill
            let crossFade = SKTransition.crossFade(withDuration: 0.75)
            if let spriteview = self.view{
                spriteview.presentScene(gameScene, transition: crossFade)
            }
        }
}
