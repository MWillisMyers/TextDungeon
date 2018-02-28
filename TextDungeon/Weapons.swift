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
//Physical Weapons
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
//Magical Weapons
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
        var undeadDoubleDamage = true
    }
    struct IronWood {
        //all magic converted to physical damage, not known what effect this will have. maybe damage reistance modifiers on enemys?
        var attack = getRandomNumber(upper: 66, lower: 33)
        var name = "Ironwood"
        var weight:Double = Double(getRandomNumber(upper: 10, lower: 5))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    
}
//Ranger Weapons
enum RangerWeaponMaterials { // this enum holds a bunch of structs that define the weapon materials stats, so we can change later if necissary
    struct Short {
        var attack = getRandomNumber(upper: 5, lower: 1)
        var name = "Short Bow"
        var weight = Double(getRandomNumber(upper: 1, lower: 1))
        var rarity = 0
    }
    struct Long {
        var attack = getRandomNumber(upper: 20, lower: 1)
        var name = "Long Bow"
        var weight:Double = Double(getRandomNumber(upper: 2, lower: 1))
        var rarity = getRandomNumber(upper: 1, lower: 0)
    }
    struct Hunter {
        var attack = getRandomNumber(upper: 15, lower: 1)
        var name = "Hunter Bow"
        var weight:Double = Double(getRandomNumber(upper: 1, lower: 1))
        var rarity = getRandomNumber(upper: 1, lower: 0)
        var undeadDoubleDamage = true
    }
    struct Crossbow {
        var attack = getRandomNumber(upper: 60, lower: 15)
        var name = "Crossbow"
        var weight:Double = Double(getRandomNumber(upper: 5, lower: 3))
        var rarity = getRandomNumber(upper: 2, lower: 0)
    }
    struct Elven {
        var attack = getRandomNumber(upper: 70, lower: 35)
        var name = "Eleven Bow"
        var weight:Double = Double(getRandomNumber(upper: 1, lower: 1))
        var rarity = getRandomNumber(upper: 3, lower: 1)
    }
    struct Dragon {
        var attack = getRandomNumber(upper: 100, lower: 50)
        var name = "Dragon Bow"
        var weight:Double = Double(getRandomNumber(upper: 7, lower: 5))
        var rarity = getRandomNumber(upper: 3, lower: 1)
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

class Staff: Weapon {
    convenience init(material:Int) { //integer based material chooser, chooses different material based on integer
        let matMaple = MagicalWeaponMaterials.Maple(), matOak = MagicalWeaponMaterials.Oak(), matElder = MagicalWeaponMaterials.Elder(), matDarkWood = MagicalWeaponMaterials.DarkWood(), matSilverWood = MagicalWeaponMaterials.SilverWood(), matIronWood = MagicalWeaponMaterials.IronWood()
        switch material {
        case 0: //Maple
            self.init(attack: matMaple.attack, name: "\(matMaple.name) Staff", rarity: matMaple.rarity, weight: matMaple.weight)
        case 1: //Oak
            self.init(attack: matOak.attack, name: "\(matOak.name) Staff", rarity: matOak.rarity, weight: matOak.weight)
        case 2: //Elder
            self.init(attack: matElder.attack, name: "\(matElder.name) Staff", rarity: matElder.rarity, weight: matElder.weight)
        case 3: //Darkwood
            self.init(attack: matDarkWood.attack, name: "\(matDarkWood.name) Staff", rarity: matDarkWood.rarity, weight: matDarkWood.weight)
        case 4: //Silverwood
            self.init(attack: matSilverWood.attack, name: "\(matSilverWood.name) Staff", rarity: matSilverWood.rarity, weight: matSilverWood.weight)
            self.doubleUndeadDamage = matSilverWood.undeadDoubleDamage
        case 5: //Ironwood
            self.init(attack: matIronWood.attack, name: "\(matIronWood.name) Staff", rarity: matIronWood.rarity, weight: matIronWood.weight)
        default: //should never be this
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0)
        }
    }
    
}

class Bow: Weapon {
    convenience init(material:Int) {
        let matShort = RangerWeaponMaterials.Short(), matLong = RangerWeaponMaterials.Long(), matHunter = RangerWeaponMaterials.Hunter(), matCrossbow = RangerWeaponMaterials.Crossbow(), matElven = RangerWeaponMaterials.Elven(), matDragon = RangerWeaponMaterials.Dragon()
        switch material {
        case 0: //Short
            self.init(attack: matShort.attack, name: "\(matShort.name) Bow)", rarity: matShort.rarity, weight: matShort.weight)
        case 1: //Long
            self.init(attack: matLong.attack, name: "\(matLong.name) Bow", rarity: matLong.rarity, weight: matLong.weight)
        case 2: //Hunter
            self.init(attack: matHunter.attack, name: "\(matHunter.name) Bow", rarity: matHunter.rarity, weight: matHunter.weight)
        case 3: //Crossbow
            self.init(attack: matCrossbow.attack, name: "\(matCrossbow.name) Bow", rarity: matCrossbow.rarity, weight: matCrossbow.weight)
        case 4: //Elven
            self.init(attack: matElven.attack, name: "\(matElven.name) Bow", rarity: matElven.rarity, weight: matElven.weight)
        case 5: //Dragon
            self.init(attack: matDragon.attack, name: "\(matDragon.name)Bow", rarity: matDragon.rarity, weight: matDragon.weight)
        default:
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0)
        }
    }
}

class Arrow: Weapon { //Arrow class taken from dagger class, added self.weight and self.attack
    override init(attack: Int, name: String, rarity: Int, weight:Double) { //override init that will take weight off because it's a dagger
        super.init(attack:attack, name:name, rarity:rarity, weight:weight)
        self.weight = 0
        self.attack /= 2 + 1
    }
    convenience init(material:Int) { //random initalizer
        let matDull = PhysicalWeaponMaterials.Dull(), matIron = PhysicalWeaponMaterials.Iron(), matSilver = PhysicalWeaponMaterials.Silver(), matCobalt = PhysicalWeaponMaterials.Cobalt(), matElven = PhysicalWeaponMaterials.Elven(), matDragon = PhysicalWeaponMaterials.Dragon()
        switch material {
        case 0: //wooden
            self.init(attack: matDull.attack, name: "Wooden Arrow", rarity: matDull.rarity, weight: matDull.weight)
        case 1: //iron
            self.init(attack: matIron.attack, name: "Iron Arrow", rarity: matIron.rarity, weight: matIron.weight)
        case 2: //silver
            self.init(attack: matSilver.attack, name: "Silver Arrow", rarity: matSilver.rarity, weight: matSilver.weight)
            self.doubleUndeadDamage = matSilver.undeadDoubleDamage
        case 3: //cobalt
            self.init(attack: matCobalt.attack, name: "Cobalt Arrow", rarity: matCobalt.rarity, weight: matCobalt.weight)
        case 4: //elven
            self.init(attack: matElven.attack, name: "Elven Arrow", rarity: matElven.rarity, weight: matElven.weight)
        case 5: //dragonbone
            self.init(attack: matDragon.attack, name: "Dragonbone Arrow", rarity: matDragon.rarity, weight: matDragon.weight)
        default:
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0)
        }
    }
}


//MARK: Functions
/*
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
*/
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


