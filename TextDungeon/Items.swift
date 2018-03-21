//
//  Items.swift
//  TextDungeon
//
//  Created by install on 2/12/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import Foundation
import GameKit
import GameplayKit
import os.log

enum potionEffects {
    case Heal
    case Damage
    case Poision
    case Speed
    case Slow
}

class Item {
    
}

class Potion: Item {
    let potionEffect:potionEffects
    let modifier:Int
    init(modifier:Int) {
        let chooser = getRandomNumber(upper: 1, lower: 5)
        switch chooser {
        case 1:
            potionEffect = .Heal
        case 2:
            potionEffect = .Damage
        case 3:
            potionEffect = .Poision
        case 4:
            potionEffect = .Speed
        case 5:
            potionEffect = .Slow
        default:
            potionEffect = .Damage
        }
        self.modifier = modifier
    }
}
