//
//  Fruit.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/16/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

enum fruitCollection: String, CaseIterable{
    case apple = "apple"
    case banana = "banana"
    case grapefruit = "grapefruit"
    case lemon = "lemon"
    case lime = "lime"
    case orange = "orange"
    case peach = "peach"
    case pear = "pear"
    case strawberry = "strawberry"
}

class Fruit: SKSpriteNode, SKPhysicsContactDelegate{
    let fruitCategory: UInt32 = 0x1 << 1
    
    init(){
        let randomfruit = fruitCollection.allCases.randomElement()!
        let fruit = SKTexture(imageNamed: randomfruit.rawValue)
        let color = UIColor.clear
        let size = CGSize(width: 40, height: 40)
        super.init(texture: fruit, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = fruitCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Fruit
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Basket
        self.physicsBody?.collisionBitMask = PhysicsCategory.Basket
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
