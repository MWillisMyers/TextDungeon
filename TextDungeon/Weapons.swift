//
//  Items.swift
//  TextDungeon
//
//  Created by Metalface on 2/2/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//
/*
 but yeah i need to figure out the values for attack
 Attack value ranges from 1 - 100, and as you get farther the enemies will scale

 
 planned feature: durability
 each material has a base durability, included in class
 weapons can be disassembled to materials whitch can add durability back into that weapon
 
 in progress: magical items, like staffs, books.
 staff has all properties of physical item, except is also ranged.
 */

import Foundation
import GameKit
import GameplayKit
import os.log

//MARK: WeaponMaterials
enum PhysicalWeaponMaterials { // this enum holds a bunch of structs that define the weapon materials stats, so we can change later if necissary
    struct Dull {
        var attack = getRandomNumber(upper: 10, lower: 1)
        var name = "Dull"
        var weight = Double(getRandomNumber(upper: 3, lower: 1))
        var rarity = 0
    }
    struct Iron {
        var attack = getRandomNumber(upper: 25, lower: 5)
        var name = "Iron"
        var weight:Double = Double(getRandomNumber(upper: 6, lower: 4))
        var rarity = getRandomNumber(upper: 1, lower: 0)
    }
    struct Silver {
        var attack = getRandomNumber(upper: 20, lower: 5)
        var name = "Silver"
        var weight:Double = Double(getRandomNumber(upper: 6, lower: 4))
        var rarity = getRandomNumber(upper: 1, lower: 0)
        var undeadDoubleDamage = true
    }
    struct Cobalt {
        var attack = getRandomNumber(upper: 33, lower: 10)
        var name = "Cobalt"
        var weight:Double = Double(getRandomNumber(upper: 6, lower: 3))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    struct Elven {
        var attack = getRandomNumber(upper: 66, lower: 33)
        var name = "Eleven"
        var weight:Double = Double(getRandomNumber(upper: 3, lower: 1))
        var rarity = getRandomNumber(upper: 3, lower: 1)
    }
    struct Dragon {
        var attack = getRandomNumber(upper: 100, lower: 50)
        var name = "Dragon"
        var weight:Double = Double(getRandomNumber(upper: 10, lower: 5))
        var rarity = getRandomNumber(upper: 3, lower: 1)
    }
}
enum MagicalWeaponMaterials {
    //Still need to define magical aspects/elemental
    //Attack and weight subject to change
    //Attack var = physical damage
    struct Maple {
        var attack = getRandomNumber(upper: 10, lower: 1)
        var name = "Maplewood"
        var weight:Double = Double(getRandomNumber(upper: 2, lower: 1))
        var rarity = 0
    }
    struct Oak {
        var attack = getRandomNumber(upper: 15, lower: 3)
        var name = "Oakwood"
        var weight:Double = Double(getRandomNumber(upper: 3, lower: 1))
        var rarity = getRandomNumber(upper: 1, lower: 0)
    }
    struct Elder {
        var attack = getRandomNumber(upper: 25, lower: 10)
        var name = "Elderwood"
        var weight:Double = Double(getRandomNumber(upper: 5, lower: 2))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    struct DarkWood {
        var attack = getRandomNumber(upper: 30, lower: 15)
        var name = "Darkwood"
        var weight:Double = Double(getRandomNumber(upper: 5, lower: 2))
        var rarity = getRandomNumber(upper: 3, lower: 0)
    }
    struct SilverWood {
        //undead staff type
        var attack = getRandomNumber(upper: 20, lower: 8)
        var name = "Silverwood"
        var weight:Double = Double(getRandomNumber(upper: 4, lower: 2))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    struct IronWood {
        //all magic converted to physical damage
        var attack = getRandomNumber(upper: 66, lower: 33)
        var name = "Ironwood"
        var weight:Double = Double(getRandomNumber(upper: 10, lower: 5))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    
}



//MARK: Classes
//weapon superclass
class Weapon: NSObject, NSCoding {
    var attack:Int
    var name:String
    var weight:Double
    var rarity:Int
    var doubleUndeadDamage:Bool = false //dont add in the init script for simplicity, will define later in subclass init
    
    init(attack:Int, name:String, rarity:Int, weight:Double) {
        self.attack = attack
        self.rarity = rarity
        self.name = name
        self.weight = weight
    }
    
    
    // All NSCoder stuff for inventory persistance
    struct propKeys {
        static let attack = "attack"
        static let name = "name"
        static let weight = "weight"
        static let rarity = "rarity"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(attack, forKey: propKeys.attack)
        aCoder.encode(name, forKey: propKeys.name)
        aCoder.encode(weight, forKey: propKeys.weight)
        aCoder.encode(rarity, forKey: propKeys.rarity)
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("inventory")
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        
        guard let name = aDecoder.decodeObject(forKey: propKeys.name) as? String
            else {
                os_log("unable to decode name", log: OSLog.default, type: .debug)
                return nil
        }
        let attack = aDecoder.decodeInteger(forKey: propKeys.attack)
        let weight = aDecoder.decodeDouble(forKey: propKeys.weight)
        let rarity = aDecoder.decodeInteger(forKey: propKeys.rarity)
        
        self.init(attack:attack, name:name, rarity:rarity, weight:weight)
    }
}

//Weapon Subclasses

class Sword: Weapon {
    convenience init(material:Int) { //integer based material chooser, chooses different material based on integer
        let matDull = PhysicalWeaponMaterials.Dull(), matIron = PhysicalWeaponMaterials.Iron(), matSilver = PhysicalWeaponMaterials.Silver(), matCobalt = PhysicalWeaponMaterials.Cobalt(), matElven = PhysicalWeaponMaterials.Elven(), matDragon = PhysicalWeaponMaterials.Dragon()
        switch material {
        case 0: //dull
            self.init(attack: matDull.attack, name: "\(matDull.name) Sword", rarity: matDull.rarity, weight: matDull.weight)
        case 1: //iron
            self.init(attack: matIron.attack, name: "\(matIron.name) Sword", rarity: matIron.rarity, weight: matIron.weight)
        case 2: //silver
            self.init(attack: matSilver.attack, name: "\(matSilver.name) Sword", rarity: matSilver.rarity, weight: matSilver.weight)
            self.doubleUndeadDamage = matSilver.undeadDoubleDamage
        case 3: //cobalt
            self.init(attack: matCobalt.attack, name: "\(matCobalt.name) Sword", rarity: matCobalt.rarity, weight: matCobalt.weight)
        case 4: //elven
            self.init(attack: matElven.attack, name: "\(matElven.name) Sword", rarity: matElven.rarity, weight: matElven.weight)
        case 5: //dragon
            self.init(attack: matDragon.attack, name: "\(matDragon.name) Sword", rarity: matDragon.rarity, weight: matDragon.weight)
        default: //should never be this
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0)
        }
    }
}

class Dagger: Weapon {
    override init(attack: Int, name: String, rarity: Int, weight:Double) { //override init that will take weight off because it's a dagger
        super.init(attack:attack, name:name, rarity:rarity, weight:weight)
        self.weight = weight / 2.0
    }
    convenience init(material:Int) { //random initalizer
        let matDull = PhysicalWeaponMaterials.Dull(), matIron = PhysicalWeaponMaterials.Iron(), matSilver = PhysicalWeaponMaterials.Silver(), matCobalt = PhysicalWeaponMaterials.Cobalt(), matElven = PhysicalWeaponMaterials.Elven(), matDragon = PhysicalWeaponMaterials.Dragon()
        switch material {
        case 0: //dull
            self.init(attack: matDull.attack, name: "\(matDull.name) Dagger", rarity: matDull.rarity, weight: matDull.weight)
        case 1: //iron
            self.init(attack: matIron.attack, name: "\(matIron.name) Dagger", rarity: matIron.rarity, weight: matIron.weight)
        case 2: //silver
            self.init(attack: matSilver.attack, name: "\(matSilver.name) Dagger", rarity: matSilver.rarity, weight: matSilver.weight)
            self.doubleUndeadDamage = matSilver.undeadDoubleDamage
        case 3: //cobalt
            self.init(attack: matCobalt.attack, name: "\(matCobalt.name) Dagger", rarity: matCobalt.rarity, weight: matCobalt.weight)
        case 4: //elven
            self.init(attack: matElven.attack, name: "\(matElven.name) Dagger", rarity: matElven.rarity, weight: matElven.weight)
        case 5: //dragon
            self.init(attack: matDragon.attack, name: "\(matDragon.name) Dagger", rarity: matDragon.rarity, weight: matDragon.weight)
        default:
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0)
        }
    }
}
class Arrow: Weapon{
    
}

//MARK: Functions

func Debug() {
    let randomSword1 = randCommonSword()
    let randomSword2 = randUncommonSword()
    let randomDagger1 = randCommonDagger()
    let silverSword = Sword(material: 2)
    print(randomSword1.name, randomSword1.attack)
    print(randomSword2.name, randomSword2.attack, randomSword2.doubleUndeadDamage)
    print(randomDagger1.name, randomDagger1.attack, randomDagger1.doubleUndeadDamage)
    print(silverSword.name, silverSword.attack, silverSword.doubleUndeadDamage)
}

func randCommonSword() -> Sword {
    //can limit material of sword by limiting upper material bound
    return Sword(material: getRandomNumber(upper: 3, lower: 1))
    }
func randUncommonSword() -> Sword {
    return Sword(material: getRandomNumber(upper: 4, lower: 1))
}
func randCommonDagger() -> Dagger {
    return Dagger(material: getRandomNumber(upper: 3, lower: 1))
}



//random number generator
func getRandomNumber (upper: Int, lower: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}


