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
//MARK: PhysicalWeaponMaterial
enum PhysicalWeaponMaterials { // this enum holds a bunch of structs that define the weapon materials stats, so we can change later if nessicary
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
        var name = "Cobalt"
        var weight:Double = Double(getRandomNumber(upper: 3, lower: 1))
        var rarity = getRandomNumber(upper: 3, lower: 1)
    }
    struct Dragon {
        var attack = getRandomNumber(upper: 100, lower: 50)
        var name = "Cobalt"
        var weight:Double = Double(getRandomNumber(upper: 10, lower: 5))
        var rarity = getRandomNumber(upper: 3, lower: 1)
    }
}


//weapon superclass
class Weapon {
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
}

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
    override init(attack: Int, name: String, rarity: Int, weight:Double) {
        super.init(attack:attack, name:name, rarity:rarity, weight:weight)
        self.weight = weight / 2.0
    }
    convenience init(material:Int) {//random initalizer
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
let starterSword = Sword(material: 0)
func Debug() {
    let randomSword1 = randCommonSword()
    let randomSword2 = randUncommonSword()
    let randomDagger1 = randCommonDagger()
    print(randomSword1.name, randomSword1.attack)
    print(randomSword2.name, randomSword2.attack)
    print(randomDagger1.name, randomDagger1.attack)
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




let sword =




func getRandomNumber (upper: Int, lower: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}

/* this all is goddamn useless


protocol sword {
    var Name:String {get set}
    var Weight:Int {get set}
    var Attack:Int {get set}
    var typeOfWeapon:PhysicalWeaponType {get set}
    var Rarity:Int {get set}
}
enum PhysicalWeaponType {
    case Sword
    case Dagger
    case Arrow
}
//MARK: Dull
struct Dull: sword {
    var Name:String
    var Weight:Int = getRandomNumber(upper:4,lower:1)
    var Attack:Int = getRandomNumber(upper:10,lower:1)
    var typeOfWeapon:PhysicalWeaponType
    var Rarity:Int = 0
    init(Name:String, typeOfWeapon:PhysicalWeaponType) {
        //properties set by random dropper
        self.Name = Name
        self.typeOfWeapon = typeOfWeapon
    }
}
//MARK: Silver
struct Silver: sword {
    var Name:String
    var Weight:Int = getRandomNumber(upper:4, lower:1)
    var Attack:Int = getRandomNumber(upper:25, lower:5)
    var typeOfWeapon:PhysicalWeaponType
    var Rarity:Int = 0
    init(Name:String, typeOfWeapon:PhysicalWeaponType) {
        //properties set by random dropper
        self.Name = Name
        self.typeOfWeapon = typeOfWeapon
    }
}
//MARK:Cobalt
/*
struct Cobalt: sword {
    var Name:String
    var Weight:Int
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:PhysicalWeaponType
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:PhysicalWeaponType) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}
struct Elven: sword {
    var Name:String
    var Weight:Int
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:PhysicalWeaponType
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:PhysicalWeaponType) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}
*/
let StarterSword = Dull(Name:"Dull Sword", typeOfWeapon: PhysicalWeaponType.Sword)
let StarterSword2 = Dull(Name: "Dull Sword", typeOfWeapon: PhysicalWeaponType.Sword)


func Debug() {
    print(StarterSword.Attack, StarterSword.Rarity)
    print(StarterSword2.Attack, StarterSword2.Rarity)
    let Weap1 = dropCommonWeapon()
    print(Weap1.Name, Weap1 .Attack)
}
func dropCommonWeapon() -> sword {
    let weaponTypeDull = Dull(Name:"Dull Sword", typeOfWeapon:PhysicalWeaponType.Sword)
    let weaponTypeSilver = Silver(Name: "Silver Sword", typeOfWeapon: PhysicalWeaponType.Sword)
    var droppedWeapon = [weaponTypeDull, weaponTypeSilver] as? sword
    return droppedWeapon([getRandomNumber(upper: 0, lower: 1)])
}



func getRandomNumber (upper: Int, lower: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}
*/
