//
//  enemy.swift
//  TextDungeon
//
//  Created by Metalface on 2/15/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//
import Foundation
import os.log

class Enemy: entity {
    var Name:String
    init(Health: Int, Attack: Double, Speed: Int, Name:String) {
        self.Name = Name
        super.init(Health: Health, Attack: Attack, Speed: Speed)
        self.Health = Health
        self.Attack = Attack
        self.Speed = Speed
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
class Goblin: Enemy {
    convenience init(level:Double) {
        let levelupper = level / 10 + level
        var levellower = level / 10 - level
        levellower = levellower.magnitude //get absolute value of lowerlevel
        print(levelupper, levellower)
        self.init(
            Health: Int(level),
            Attack: Double(getRandomNumber(upper: Int(levelupper), lower: Int(levellower)) + 1),
            Speed: Int(level),
            Name: "Goblin"
        )
    }
}

let goblin1 = Goblin(level: 1)
extension ViewController {
    func enemyDebug() {
        print(goblin1.Name, goblin1.Attack, goblin1.Health, goblin1.Speed)
        enemyEngaged(enemy: goblin1)
    }
}

