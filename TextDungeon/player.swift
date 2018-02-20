
//
//  player.swift
//  TextDungeon
//
//  Created by Metalface on 2/1/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

/*
 So this is the file we're doing player stuff in...
 how about that!
 */
import Foundation

class entity {
    var Health: Int
    var Attack: Double
    var Speed: Int
    init(Health:Int, Attack:Double, Speed:Int) {
        self.Health = Health
        self.Attack = Attack
        self.Speed = Speed
    }
}


//base player class

class player: entity {
    var Gold: Int
    var Experience: Int
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int) {
        self.Gold = Gold //you're broke lmao
        self.Experience = Experience
        super.init(Health: Health, Attack: Attack, Speed: Speed)
    }
}
 




//subclasses of each of the characters
class sorcerer: player {
    var Mana:Int
    var spAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Mana:Int, spAttack:Double) {
        self.Mana = 100
        self.spAttack = 1.0
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience)
        self.Attack = 1
        self.Experience = 0
        self.Health = 10
        self.Speed = 1
        self.Gold = 0
    }
}

class barbarian: player {
    var Power:Double //since the barbarian has nothing but melee, i'm going to add another base modifier that buffs his damage
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Power:Double) {
        self.Power = 1.0
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience)
        self.Attack = 1
        self.Experience = 0
        self.Health = 10
        self.Speed = 1
        self.Gold = 0
    }
}

// Hello Office Phantom.
//hello random person
/*
 You're the one invading my machine.
 I just need to code
 Shouldnt you be doing school work?
 That's ridiculous why would i do that
 Gee I don't know Logan. Why would you do that, its not like you're at school
 I mean it's a demo i've already done and i have some free time
 Uh huh
 Well GLHF
 I'm going to code now okay
 yeah yeah
 New computers should be here monday or tuesday
 Monday is presidents day
 pfunder said friday D:
 rip
 they will be here friday "Sometime"
 okay good talk matt
 ooooOOOOOOooooooOOOOOOooooOOO
 Office Phantom out.
 
 */

class ranger: player {
    var hitChance:Double
    var rangedAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, hitChance:Double, rangedAttack:Double) {
        self.hitChance = 0.5
        self.rangedAttack = 1.0
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience)
        self.Attack = 1
        self.Experience = 0
        self.Health = 10
        self.Speed = 1
        self.Gold = 0
    }
    /*
     the archer will be based on hit chance, so that when the player engages on an enemy farther away
     you have to spend points on your chance to hit that enemy. If the enemy is a Melee only, he will
     come closer to you over a few turns and try to hit you. If he does come close enough the ranger
     will have to resort to his knife. Enemys that have ranged/magic attacks will stay far and also have
     a hit chance. */
}

class preist: player {
    var healRate:Int?
}
