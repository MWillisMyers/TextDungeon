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
 Dull = 1 - 10
 Iron = 1 - 33
 Silver = 1 - 33
 Cobalt = 33 - 66
 Elven = 33 - 100
 Dragon = 66 - 100
 */
import Foundation
import GameKit
import GameplayKit

/*
struct Dull {
    var attack = getRandomNumber(upper: 10, lower: 1)
    var name = "Dull"
    var weight = getRandomNumber(upper: 1, lower: 3)
    var rarity = 0
}
struct Iron {
    var attack = getRandomNumber(upper: 25, lower: 5)
    var name = "Iron"
    var weight:Double = Double(getRandomNumber(upper: 4, lower: 6))
    var rarity = getRandomNumber(upper: 1, lower: 0)
}
struct Cobalt {
    var attack = getRandomNumber(upper: 33, lower: 10)
    var name = "Cobalt"
    var weight:Double = Double(getRandomNumber(upper: 4, lower: 6))
    var rarity = getRandomNumber(upper: 2, lower: 0)
}
*/

//weapon superclass
class Weapon {
    var attack:Int
    var name:String
    var weight:Double
    var rarity:Int
    var doubleUndeadDamage:Bool
    init(attack:Int, name:String, rarity:Int, weight:Double, doubleUndeadDamage:Bool) {
        self.attack = attack
        self.rarity = rarity
        self.name = name
        self.weight = weight
        self.doubleUndeadDamage = doubleUndeadDamage
    }
}

class Sword: Weapon {
    convenience init(material:Int) { //random initalizer, chooses different material based on integer
        switch material {
        case 0: //dull
            self.init(attack: getRandomNumber(upper: 10, lower: 1), name: "Dull Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 1: //iron
           self.init(attack: getRandomNumber(upper: 25, lower: 5), name: "Iron Sword", rarity: getRandomNumber(upper: 1, lower: 0), weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 2: //silver
            self.init(attack: getRandomNumber(upper: 25, lower: 5), name: "Silver Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: true)
        case 3: //cobalt
            self.init(attack: getRandomNumber(upper: 33, lower: 10), name: "Cobalt Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 4: //elven
            self.init(attack: getRandomNumber(upper: 66, lower: 33), name: "Elven Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 5: //dragon
            self.init(attack: getRandomNumber(upper: 100, lower: 66), name: "Dragon Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        default:
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0, doubleUndeadDamage: false)
        }
    }
}



class Dagger: Weapon {
    override init(attack: Int, name: String, rarity: Int, weight:Double, doubleUndeadDamage:Bool) {
        super.init(attack:attack, name:name, rarity:rarity, weight:weight, doubleUndeadDamage:doubleUndeadDamage)
        self.weight = weight / 2.0
    }
    convenience init(material:Int) { //random initalizer
        switch material {
        case 0: //dull
            self.init(attack: getRandomNumber(upper: 10, lower: 1), name: "Dull Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 1: //iron
            self.init(attack: getRandomNumber(upper: 25, lower: 5), name: "Iron Sword", rarity: getRandomNumber(upper: 1, lower: 0), weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 2: //silver
            self.init(attack: getRandomNumber(upper: 25, lower: 5), name: "Silver Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: true)
        case 3: //cobalt
            self.init(attack: getRandomNumber(upper: 33, lower: 10), name: "Cobalt Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 4: //elven
            self.init(attack: getRandomNumber(upper: 66, lower: 33), name: "Elven Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        case 5: //dragon
            self.init(attack: getRandomNumber(upper: 100, lower: 66), name: "Dragon Sword", rarity: 0, weight: Double(getRandomNumber(upper: 3, lower: 1)), doubleUndeadDamage: false)
        default:
            self.init(attack: 1, name: "Default", rarity: 0, weight: 1.0, doubleUndeadDamage: false)
        }
    }
}
class Arrow: Weapon{
    
}
let starterSword = Sword(material: 0)
func Debug() {
    let randomSword1 = randCommonSword()
    let randomSword2 = randUncommonSword()
    let randomDagger1 = 
    print(randomSword1.name, randomSword1.attack)
    print(randomSword2.name, randomSword2.attack)
}

func randCommonSword() -> Sword {
    //can limit material of sword by limiting upper material bound
    return Sword(material: getRandomNumber(upper: 3, lower: 1))
    }
func randUncommonSword() -> Sword {
    return Sword(material: getRandomNumber(upper: 4, lower: 1))
}









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
