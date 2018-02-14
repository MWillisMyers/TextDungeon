
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
//base player class
/*
 class player {
 var Health: Int
 var Attack: Double
 var Speed: Int
 var Gold: Int
 var Experience: Int
 init?(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int) {
 self.Speed = Speed //higher speed means attack first, this game is legit just a pokemon clone without the pokemon
 self.Attack = Attack // this is probably going to be a multiplier on the player's attacks
 self.Health = Health
 self.Gold = Gold //you're broke lmao
 self.Experience = Experience
 }
 }
 */
protocol player {
    var Health: Int {get set}
    var Attack: Double {get set}
    var Speed: Int {get set}
    var Gold: Int {get set}
    var Experience: Int {get set}
}




//subclasses of each of the characters
class sorcerer: player {
    var Health: Int
    var spAttack:Double
    override init(Mana:Int, spAttack:Double) {
        Mana = 100
        spAttack = 1.0 //another multiplier
    }
}

class barbarian: player {
    var Power:Int? //since the barbarian has nothing but melee, i'm going to add another base modifier that buffs his damage
}

class ranger: player {
    var hitChance:Double
    var rangedAttack:Double
    override init() {
        hitChance = 0.5 //maybe a base hit chance?
        rangedAttack = 1.0
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
