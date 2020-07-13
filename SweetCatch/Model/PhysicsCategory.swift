//
//  PhysicsCategory.swift
//  SweetCatch
//
//  Created by Benjamin Simpson on 7/13/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let Vacant:   UInt32 = 0 
    static let Basket:   UInt32 = 0b1
    static let Fruit:    UInt32 = 0b10
    static let BadFruit: UInt32 = 0b100
}
