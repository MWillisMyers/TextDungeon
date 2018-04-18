
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
 
 Battle Plan:
 Each character has 4 attacks.
 Barbarian: Light Attack, Heavy Attack, Charged Blow, Block
 Ranger: Light Draw, Full Draw, Throw Knife, Pet
 Priest: Light Heal, Full Heal, Shield Team, Attack
 Sorcerer: Spell 1, Spell 2, Spell 3 (special), Melee Strike
 Most of these are subject to change functionality and name.
 there will be a bar with energy used to attack, and this energy regens every turn.
 heavier attacks will use more energy.
 
 We REALLY need a plan for the sorcerer. Books especially.



 */
/*
 the archer will be based on hit chance, so that when the player engages on an enemy farther away
 you have to spend points on your chance to hit that enemy. If the enemy is a Melee only, he will
 come closer to you over a few turns and try to hit you. If he does come close enough the ranger
 will have to resort to his knife. Enemys that have ranged/magic attacks will stay far and also have
 a hit chance. */

import Foundation
import os.log

let seperator = " | " //seperates the numbers when printing them
//MARK:Entity superclass
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

//MARK: Base Player Class
class player: entity {
    var Gold: Int
    var Experience: Int
    let Name: String
    var isDead: Bool
    var Stamina: Int
    var MaxStamina: Int
    var equippedWeapon: Weapon?
    init(Health:Int,
         Attack:Double,
         Speed:Int,
         Gold:Int,
         Experience:Int,
         Name:String,
         isDead:Bool,
         Stamina: Int,
         MaxStamina: Int,
         equippedWeapon:Weapon?
        ) {
        self.Gold = Gold
        self.Experience = Experience
        self.Name = Name
        self.isDead = isDead
        self.Stamina = Stamina
        self.MaxStamina = MaxStamina
        self.equippedWeapon = equippedWeapon
        super.init(Health: Health, Attack: Attack, Speed: Speed)
    }
    private enum CodingKeys: String, CodingKey {
        case Gold
        case Experience
        case Name
        case isDead
        case Stamina
        case MaxStamina
        case equippedWeapon
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Gold = try values.decode(Int.self, forKey: .Gold)
        Experience = try values.decode(Int.self, forKey: .Experience)
        Name = try values.decode(String.self, forKey: .Name)
        isDead = try values.decode(Bool.self, forKey: .isDead)
        Stamina = try values.decode(Int.self, forKey: .Stamina)
        MaxStamina = try values.decode(Int.self, forKey: .MaxStamina)
        equippedWeapon = try values.decodeIfPresent(Weapon.self, forKey: .equippedWeapon)
        try super.init(from: decoder)
        }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Gold, forKey: .Gold)
        try container.encode(Experience, forKey: .Experience)
        try container.encode(Name, forKey: .Name)
        try container.encode(isDead, forKey: .isDead)
        try container.encode(Stamina, forKey: .Stamina)
        try container.encode(MaxStamina, forKey: .MaxStamina)
        try container.encodeIfPresent(equippedWeapon, forKey: .equippedWeapon)
        
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players")
    
    struct skillTree {
        var skills = ["health":0, "speed":0]
        
        func addSkill() {
            
        }
    }
}


//subclasses of each of the characters
//MARK: Sorcerer
class sorcerer: player {
    var Mana:Int
    var spAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Mana:Int, spAttack:Double, Name:String, isDead:Bool, Stamina:Int, MaxStamina:Int, equippedWeapon:Weapon?) {
        self.Mana = Mana //value used for magical attacks
        self.spAttack = spAttack //modifier for magical attacks
        super.init(Health: Health,
                   Attack: Attack,
                   Speed: Speed,
                   Gold: Gold,
                   Experience: Experience,
                   Name:"Sorcerer",
                   isDead:isDead,
                   Stamina:Stamina,
                   MaxStamina:MaxStamina,
                   equippedWeapon:equippedWeapon
                   ) //after initalizing the class values, need to init super class values here
    }
    convenience init() { //base values init. After initaliazed the values should be loaded by Codable instead of this
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
            Stamina: 100,
            MaxStamina: 100,
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
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(Mana, forKey: .Mana)
        try container.encode(spAttack, forKey: .spAttack)
    }
}
//MARK:Barbarian
class barbarian: player {
    var Power:Double //since the barbarian has nothing but melee, i'm going to add another base modifier that buffs his damage
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, Power:Double, Name:String, isDead:Bool, Stamina:Int, MaxStamina:Int, equippedWeapon:Weapon?) {
        self.Power = Power
        super.init(
            Health: Health,
            Attack: Attack,
            Speed: Speed,
            Gold: Gold,
            Experience: Experience,
            Name:"Barbarian",
            isDead:isDead,
            Stamina:Stamina,
            MaxStamina:MaxStamina,
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
            Stamina: 100,
            MaxStamina: 100,
            equippedWeapon: nil
        )
    }
    private enum CodingKeys: String, CodingKey {
        case Power
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



//MARK:Ranger
class ranger: player {
    var hitChance:Double
    var rangedAttack:Double
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, hitChance:Double, rangedAttack:Double, Name:String, isDead:Bool, Stamina:Int, MaxStamina:Int, equippedWeapon:Weapon?) {
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
            Stamina:Stamina,
            MaxStamina:MaxStamina,
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
            Stamina: 100,
            MaxStamina: 100,
            equippedWeapon: nil
        )
    }
    private enum CodingKeys: String, CodingKey {
        case rangedAttack
        case hitChance
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rangedAttack = try values.decode(Double.self, forKey: .rangedAttack)
        hitChance = try values.decode(Double.self, forKey: .hitChance)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(rangedAttack, forKey: .rangedAttack)
        try container.encode(hitChance, forKey: .hitChance)
    }
}
//MARK:Priest
class preist: player {
    var healRate:Int
    init(Health:Int, Attack:Double, Speed:Int, Gold:Int, Experience:Int, healRate:Int, Name:String, isDead:Bool, Stamina:Int, MaxStamina:Int, equippedWeapon:Weapon?) {
        self.healRate = healRate
        super.init(
            Health: Health,
            Attack: Attack,
            Speed: Speed,
            Gold: Gold,
            Experience: Experience,
            Name:Name,
            isDead:isDead,
            Stamina:Stamina,
            MaxStamina:MaxStamina,
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
            Stamina: 100,
            MaxStamina: 100,
            equippedWeapon: nil
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case healRate
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        healRate = try values.decode(Int.self, forKey: .healRate)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(healRate, forKey: .healRate)
    }
}
//MARK:Player Struct
struct Players: Codable {
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
    enum CodingKeys: String, CodingKey {
        case barbarian
        case ranger
        case priest
        case sorcerer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(charSorcerer, forKey: .sorcerer)
        try container.encode(charPriest, forKey: .priest)
        try container.encode(charRanger, forKey: .ranger)
        try container.encode(charBarbarian, forKey: .barbarian)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        charBarbarian = try container.decode(barbarian.self, forKey: .barbarian)
        charRanger = try container.decode(ranger.self, forKey: .ranger)
        charPriest = try container.decode(preist.self, forKey: .priest)
        charSorcerer = try container.decode(sorcerer.self, forKey: .sorcerer)
        activeCharacter = charBarbarian
    }
}

//MARK:Player Wrapper
struct playerWrapper {
    var playerVar = Players()
    func savePlayers() {
        do {
            let codedData = try PropertyListEncoder().encode(playerVar) //codes the data using Codable
            let save = NSKeyedArchiver.archiveRootObject(codedData, toFile: player.ArchiveURL.path) //archives it using NSArchiver
            print(save ? "save good" : "save not good")
        } catch {
            print("Save Failed")
            print(error)
        }
    }
    func loadPlayers() -> Players? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: player.ArchiveURL.path) as? Data else { return nil } //gets coded data from NSUnarchiver
        do {
            let uncodedData = try PropertyListDecoder().decode(Players.self, from: data)
            let ret = uncodedData
            print("Load Successful")
            return ret
        } catch {
            print("retrieve failed")
            print(error)
            return nil
        }
    }
    
}
//MARK: Print Stats function
extension ViewController {
    func printStats() {//print stats of all characters in
        printOut(text: "Health | Attack | Speed | Experience | Gold") //Line
        if char.playerVar.charBarbarian.isDead == false {
            printOut(text: "Barbarian") //Line
            printOut(text: //Print all of the barbarians stats  //Line
                String(describing: char.playerVar.charBarbarian.Health) + seperator +
                String(describing: char.playerVar.charBarbarian.Attack) + seperator +
                String(describing: char.playerVar.charBarbarian.Speed) + seperator +
                String(describing: char.playerVar.charBarbarian.Experience) + seperator +
                String(describing: char.playerVar.charBarbarian.Gold) + seperator +
                "Power:" + String(describing: char.playerVar.charBarbarian.Power) + seperator
            )
        } else {
            printOut(text: "The barbarian has passed away in glorious combat")
        }
        if char.playerVar.charRanger.isDead == false {
            printOut(text: "Ranger") //Line
            printOut(text: //Print all of the rangers stats     //Line
                String(describing: char.playerVar.charRanger.Health) + seperator +
                String(describing: char.playerVar.charRanger.Attack) + seperator +
                String(describing: char.playerVar.charRanger.Speed) + seperator +
                String(describing: char.playerVar.charRanger.Experience) + seperator +
                String(describing: char.playerVar.charRanger.Gold) + seperator
            )
        } else {
            printOut(text: "The ranger was killed while sticking arrows into his enemies...")
        }
       
        printOut(text: "Your active character is: \(char.playerVar.activeCharacter.Name)")
    }
}

