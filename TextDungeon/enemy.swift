//
//  enemy.swift
//  TextDungeon
//
//  Created by Metalface on 2/15/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//
/*
 ToDo:
 define each enemy type
 GET SPRITEKIT!!
 add enemy identifers and the sprites to go with them - UIImage probably
 Maybe make boss subclass...
 */
import Foundation
import os.log

// attack formula
class Enemy: entity {
    var Name:String
    init(Health: Int, Attack: Double, Speed: Int, Name:String) {
        self.Name = Name
        super.init(Health: Health, Attack: Attack, Speed: Speed)
        self.Health = Health
        self.Attack = Attack
        self.Speed = Speed
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            Attack: Double(getRandomNumber(upper: Int(levelupper), lower: Int(levellower))),
            Speed: Int(level),
            Name: "Goblin"
        )
    }
}
    

    //var sprite = ????


let goblin1 = Goblin(level: 1)
extension ViewController {
    func enemyDebug() {
        print(goblin1.Name, goblin1.Attack, goblin1.Health, goblin1.Speed)
        enemyEngaged(enemy: goblin1)
    }
}

