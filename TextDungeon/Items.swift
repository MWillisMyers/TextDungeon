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

enum weaponMaterials {
    case Dull
    case Iron
    case Silver
    case Cobalt
    case Elven
    case Dragon
}


class Weapon {
    var attack:Int
    var name:String
    var weight:Double
    var rarity:Int
    init(attack:Int, name:String, rarity:Int, weight:Double) {
        self.attack = 1
        self.rarity = rarity
        self.name = name
        self.weight = weight
    }
}

class Sword: Weapon {
    
}

class Dagger: Weapon {
    override init(attack: Int, name: String, rarity: Int, weight:Double) {
        super.init(attack:attack, name:name, rarity:rarity, weight:weight)
        self.weight = weight / 2.0
    }
}

func Debug() {
    let Dagger1 = Dagger(attack: 1, name: "Dagger", rarity: 0, weight: 10)
    print(Dagger1.weight, Dagger1.attack)
}
func DropCommonRandomWeapon() {
    let Material = getRandomNumber(upper: 3, lower: 1)
    switch Material {
    case 1:
        let weapMaterial = weaponMaterials.Dull
    case 2:
        let weapMaterial = weaponMaterials.Iron
    case 3:
        let weapMaterial = weaponMaterials.Cobalt
    default:
        let weapMaterial = weaponMaterials.Dull
    }
    
    
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
