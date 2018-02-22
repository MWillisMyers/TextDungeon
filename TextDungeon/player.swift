
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

let seperator = " | " //seperates the numbers when printing them
// entity superclass
class entity: NSObject, NSCoding {
    var Health: Int
    var Attack: Double
    var Speed: Int
    init(Health:Int, Attack:Double, Speed:Int) {
        self.Health = Health
        self.Attack = Attack
        self.Speed = Speed
    }
    // NsCOding stuff for player persistance and saving
    struct propKeys {
        static let Health = "Health"
        static let Attack = "Attack"
        static let Speed = "Speed"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Health, forKey: propKeys.Health)
        aCoder.encode(Attack, forKey: propKeys.Attack)
        aCoder.encode(Speed, forKey: propKeys.Speed)
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players")
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let Health = aDecoder.decodeInteger(forKey: propKeys.Health)
        let Attack = aDecoder.decodeDouble(forKey: propKeys.Attack)
        let Speed = aDecoder.decodeInteger(forKey: propKeys.Speed)
        
        self.init(Health:Health,Attack:Attack,Speed:Speed)
    }
}


//base player class

class player: entity { //simply adds things the characters will have
    var Gold: Int
    var Experience: Int
    var Name: String
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Name:String) {
        self.Gold = Gold //you're broke lmao
        self.Experience = Experience
        self.Name = Name
        super.init(Health: Health, Attack: Attack, Speed: Speed)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 




//subclasses of each of the characters
class sorcerer: player {
    var Mana:Int
    var spAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Mana:Int, spAttack:Double, Name:String) {
        self.Mana = Mana //value used for magical attacks
        self.spAttack = spAttack //modifier for magical attacks
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience, Name:Name) //after initalizing the class values, need to init super class values here
        self.Attack = Attack
        self.Experience = Experience
        self.Health = Health
        self.Speed = Speed
        self.Gold = Gold
        self.Name = "Sorcerer"
    }
    convenience init() { //on initalization, add base values. After initaliazed the values should be loaded by NSCoder instead of this
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            Mana: 100,
            spAttack: 1.0,
            Name: "Sorcerer"
        )
    }
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class barbarian: player {
    var Power:Double //since the barbarian has nothing but melee, i'm going to add another base modifier that buffs his damage
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Power:Double, Name:String) {
        self.Power = Power
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience, Name:Name)
        self.Attack = Attack
        self.Experience = Experience
        self.Health = Health
        self.Speed = Speed
        self.Gold = Gold
        self.Name = "Barbarian"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init() {
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            Power: 1.0,
            Name: "Barbarian"
        )
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
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, hitChance:Double, rangedAttack:Double, Name:String) {
        self.hitChance = hitChance
        self.rangedAttack = rangedAttack
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience, Name:Name)
        self.Attack = Attack
        self.Experience = Experience
        self.Health = Health
        self.Speed = Speed
        self.Gold = Gold
        self.Name = "Ranger"
    }
    convenience init() {
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            hitChance: 0.5,
            rangedAttack: 1.0,
            Name: "Ranger"
        )
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     the archer will be based on hit chance, so that when the player engages on an enemy farther away
     you have to spend points on your chance to hit that enemy. If the enemy is a Melee only, he will
     come closer to you over a few turns and try to hit you. If he does come close enough the ranger 
     will have to resort to his knife. Enemys that have ranged/magic attacks will stay far and also have
     a hit chance. */
}

class preist: player {
    var healRate:Int
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, healRate:Int, Name:String) {
        self.healRate = healRate
        super.init(Health: Health, Attack: Attack, Speed: Speed, Gold: Gold, Experience: Experience, Name:Name)
        self.Attack = Attack
        self.Experience = Experience
        self.Health = Health
        self.Speed = Speed
        self.Gold = Gold
        self.Name = "Priest"
    }
    convenience init() {
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            healRate: 1,
            Name: "Preist"
        )
    }
    
    // Yp 
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct players {
    let charBarbarian = barbarian()
    let charRanger = ranger()
    let charPriest = preist()
    let charSorcerer = sorcerer()
    var activeCharacter:player
    init() {
        activeCharacter = charBarbarian
    }
}

extension ViewController {
    func printStats() {//print stats of all characters in
        printOut(text: "Health | Attack | Speed | Experience | Gold") //Line
        printOut(text: "Barbarian") //Line
        printOut(text: //Print all of the barbarians stats  //Line
            String(describing: char.charBarbarian.Health) + seperator +
            String(describing: char.charBarbarian.Attack) + seperator +
            String(describing: char.charBarbarian.Speed) + seperator +
            String(describing: char.charBarbarian.Experience) + seperator +
            String(describing: char.charBarbarian.Gold) + seperator +
            "Power:" + String(describing: char.charBarbarian.Power) + seperator
        )
        printOut(text: "Ranger") //Line
        printOut(text: //Print all of the rangers stats     //Line
            String(describing: char.charRanger.Health) + seperator +
                String(describing: char.charRanger.Attack) + seperator +
                String(describing: char.charRanger.Speed) + seperator
        )
        printOut(text: "Your active character is: " + String(describing: char.activeCharacter))
    }
}
