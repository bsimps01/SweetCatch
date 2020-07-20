//
//  BadFruit.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/20/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class BadFruit: SKSpriteNode, SKPhysicsContactDelegate{
    let badFruitCategory: UInt32 = 0x1 << 1
    
    init(){
        //let badFruit = SKSpriteNode(imageNamed: "rottenFruit")
        let fruit = SKTexture(imageNamed: "rottenFruit")
        let color = UIColor.clear
        let size = CGSize(width: 40, height: 40)
        super.init(texture: fruit, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = badFruitCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.BadFruit
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Basket
        self.physicsBody?.collisionBitMask = PhysicsCategory.Basket
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
