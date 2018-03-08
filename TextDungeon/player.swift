
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
import os.log

let seperator = " | " //seperates the numbers when printing them
// entity superclass
class entity: Codable {
    var Health: Int
    var Attack: Double
    var Speed: Int
    init(Health:Int, Attack:Double, Speed:Int) {
        self.Health = Health
        self.Attack = Attack
        self.Speed = Speed
    }
    private enum CodingKeys: String, CodingKey {
        case Health
        case Attack
        case Speed
    }
    
}
    // NsCoding stuff for player persistance and saving
  /*   struct propKeys {
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
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entity")
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let Health = aDecoder.decodeInteger(forKey: propKeys.Health)
        let Attack = aDecoder.decodeDouble(forKey: propKeys.Attack)
        let Speed = aDecoder.decodeInteger(forKey: propKeys.Speed)
        
        self.init(Health:Health,Attack:Attack,Speed:Speed)
    }
}
*/

//base player class

class player: entity { //simply adds things the characters will have
    var Gold: Int
    var Experience: Int
    let Name: String
    var isDead: Bool
    var equippedWeapon: Weapon?
    init(Health:Int,
         Attack:Double,
         Speed:Int,
         Gold:Int,
         Experience:Int,
         Name:String,
         isDead:Bool,
         equippedWeapon:Weapon?
        ) {
        self.Gold = Gold
        self.Experience = Experience
        self.Name = Name
        self.isDead = isDead
        self.equippedWeapon = equippedWeapon
        super.init(Health: Health, Attack: Attack, Speed: Speed)
    }
    private enum CodingKeys: String, CodingKey {
        case Health
        case Attack
        case Speed
        case Gold
        case Experience
        case Name
        case isDead
        case equippedWeapon
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Gold = try values.decode(Int.self, forKey: .Gold)
        Experience = try values.decode(Int.self, forKey: .Experience)
        Name = try values.decode(String.self, forKey: .Name)
        isDead = try values.decode(Bool.self, forKey: .isDead)
        equippedWeapon = try values.decode(Weapon.self, forKey: .equippedWeapon)
        try super.init(from: Decoder.self as! Decoder)
        }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Gold, forKey: .Gold)
        try container.encode(Experience, forKey: .Experience)
        try container.encode(Name, forKey: .Name)
        try container.encode(isDead, forKey: .isDead)
        try container.encode(equippedWeapon, forKey: .equippedWeapon)
        
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players")
}


 




//subclasses of each of the characters
class sorcerer: player {
    var Mana:Int
    var spAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Mana:Int, spAttack:Double, Name:String, isDead:Bool, equippedWeapon:Weapon?) {
        self.Mana = Mana //value used for magical attacks
        self.spAttack = spAttack //modifier for magical attacks
        super.init(Health: Health,
                   Attack: Attack,
                   Speed: Speed,
                   Gold: Gold,
                   Experience: Experience,
                   Name:"Sorcerer",
                   isDead:isDead,
                   equippedWeapon:equippedWeapon
                   ) //after initalizing the class values, need to init super class values here
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
            Name: "Sorcerer",
            isDead: false,
            equippedWeapon: nil
        )
    }
    private enum CodingKeys: String, CodingKey {
        case Mana
        case spAttack
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Mana = try values.decode(Int.self, forKey: .Mana)
        spAttack = try values.decode(Double.self, forKey: .spAttack)
        try super.init(from: Decoder.self as! Decoder)
    }
}
class barbarian: player {
    var Power:Double //since the barbarian has nothing but melee, i'm going to add another base modifier that buffs his damage
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Power:Double, Name:String, isDead:Bool, equippedWeapon:Weapon?) {
        self.Power = Power
        super.init(
            Health: Health,
            Attack: Attack,
            Speed: Speed,
            Gold: Gold,
            Experience: Experience,
            Name:"Barbarian",
            isDead:isDead,
            equippedWeapon:equippedWeapon
        )
    }
    convenience init() {
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            Power: 1.0,
            Name: "Barbarian",
            isDead: false,
            equippedWeapon: nil
        )
    }
    private enum CodingKeys: String, CodingKey {
        case Power
        case Health
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Power = try values.decode(Double.self, forKey: .Power)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(Power, forKey: .Power)
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
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, hitChance:Double, rangedAttack:Double, Name:String, isDead:Bool, equippedWeapon:Weapon?) {
        self.hitChance = hitChance
        self.rangedAttack = rangedAttack
        super.init(
            Health: Health,
            Attack: Attack,
            Speed: Speed,
            Gold: Gold,
            Experience: Experience,
            Name:Name,
            isDead:isDead,
            equippedWeapon:equippedWeapon
        )
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
            Name: "Ranger",
            isDead: false,
            equippedWeapon: nil
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
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
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, healRate:Int, Name:String, isDead:Bool, equippedWeapon:Weapon?) {
        self.healRate = healRate
        super.init(
            Health: Health,
            Attack: Attack,
            Speed: Speed,
            Gold: Gold,
            Experience: Experience,
            Name:Name,
            isDead:isDead,
            equippedWeapon:equippedWeapon
        )
    }
    convenience init() {
        self.init(
            Health: 10,
            Attack: 1.0,
            Speed: 1,
            Gold: 0,
            Experience: 0,
            healRate: 1,
            Name: "Preist",
            isDead: false,
            equippedWeapon: nil
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
struct players {
    var charBarbarian = barbarian()
    var charRanger = ranger()
    var charPriest = preist()
    var charSorcerer = sorcerer()
    var activeCharacter:player
    init() {
        activeCharacter = charBarbarian
    }
    func getActiveCharacterString() -> String {
        switch activeCharacter {
        case is barbarian:
            return "Barbarian"
        case is ranger:
            return "Ranger"
        case is preist:
            return "Preist"
        case is sorcerer:
            return "Sorcerer"
        default:
            return "Game broke"
        }
    }
   func savePlayers() {
        do {
            let codedDataB = try PropertyListEncoder().encode(charBarbarian) //codes the data using Codable
            let codedDataR = try PropertyListEncoder().encode(charRanger)
           // let codedDataP = try PropertyListEncoder().encode(charPriest)
            //let codedDataS = try PropertyListEncoder().encode(charSorcerer)
            let saveB = NSKeyedArchiver.archiveRootObject(codedDataB, toFile: player.ArchiveURL.path) //archives it using NSArchiver
            let saveR = NSKeyedArchiver.archiveRootObject(codedDataR, toFile: player.ArchiveURL.path)
            //let saveP = NSKeyedArchiver.archiveRootObject(codedDataP, toFile: player.ArchiveURL.path)
           // let saveS = NSKeyedArchiver.archiveRootObject(codedDataS, toFile: player.ArchiveURL.path)
            print(saveB ? "save good Barbarian" : "save not good")
            print(saveR ? "save good Ranger" : "save not good")
            //print(saveP ? "save good Priest" : "save not good")
           // print(saveS ? "save good Sorcerer" : "save not good")
        } catch {
            print("Save Failed")
        }
    }
    func loadPlayers() -> [Any]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: player.ArchiveURL.path) as? Data else { return nil } //gets coded data from NSUnarchiver
        do {
            let uncodedDataB = try PropertyListDecoder().decode(barbarian.self, from: data) //decodes it using Codable
            let uncodedDataR = try PropertyListDecoder().decode(ranger.self, from: data)
            //let uncodedDataP = try PropertyListDecoder().decode(preist.self, from: data)
            //let uncodedDataS = try PropertyListDecoder().decode(sorcerer.self, from: data)
            let retArray = [uncodedDataB, uncodedDataR] //uncodedDataP, uncodedDataS]
            print("Load Successful")
            return retArray
        } catch {
            print("retrieve failed")
            print(error)
            return nil
        }
    }
    
    
}
extension ViewController {
    func printStats() {//print stats of all characters in
        printOut(text: "Health | Attack | Speed | Experience | Gold") //Line
        if char.charBarbarian.isDead == false {
            printOut(text: "Barbarian") //Line
            printOut(text: //Print all of the barbarians stats  //Line
                String(describing: char.charBarbarian.Health) + seperator +
                String(describing: char.charBarbarian.Attack) + seperator +
                String(describing: char.charBarbarian.Speed) + seperator +
                String(describing: char.charBarbarian.Experience) + seperator +
                String(describing: char.charBarbarian.Gold) + seperator +
                "Power:" + String(describing: char.charBarbarian.Power) + seperator
            )
        } else {
            printOut(text: "The barbarian has passed away in glorious combat")
        }
        if char.charRanger.isDead == false {
            printOut(text: "Ranger") //Line
            printOut(text: //Print all of the rangers stats     //Line
                String(describing: char.charRanger.Health) + seperator +
                String(describing: char.charRanger.Attack) + seperator +
                String(describing: char.charRanger.Speed) + seperator +
                String(describing: char.charRanger.Experience) + seperator +
                String(describing: char.charRanger.Gold) + seperator
            )
        } else {
            printOut(text: "The ranger was killed while sticking arrows into his enemies...")
        }
       
        printOut(text: "Your active character is: \(char.activeCharacter.Name)")
    }
    // save and load functions for players
    
}
