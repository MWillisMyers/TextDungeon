//
//  Items.swift
//  TextDungeon
//
//  Created by Metalface on 2/2/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import Foundation
import GameKit
import GameplayKit

protocol weapon {
    var Name:String {get set}
    var Weight:Int {get set}
    var Attack:Int {get set}
    var typeOfWeapon:String {get set}
    var Rarity:Int {get set}
}
//MARK: Dull
struct Dull: weapon {
    var Name:String
    var Weight:Int
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:String
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:String) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}
//MARK: Silver
struct Silver: weapon {
    var Name:String
    var Weight:Int = getRandomNumber(UpperBoundInt: <#T##Int#>)
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:String
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:String) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}
//MARK:Cobalt
struct Cobalt: weapon {
    var Name:String
    var Weight:Int
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:String
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:String) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}
struct Dull: weapon {
    var Name:String
    var Weight:Int
    var Attack:Int = getRandomNumber(UpperBoundInt: 5)
    var typeOfWeapon:String
    var Rarity:Int = 0
    init(Name:String, Weight:Int, typeOfWeapon:String) {
        //properties set by random dropper
        self.Name = Name
        self.Weight = Weight
        self.typeOfWeapon = typeOfWeapon
    }
}

let StarterSword = Dull(Name:"Dull Sword", Weight: 1, typeOfWeapon: "Sword")
let StarterSword2 = Dull(Name: "Dull Sword", Weight: 2, typeOfWeapon: "Sword")


func Debug() {
    print(StarterSword.Attack, StarterSword.Rarity)
    print(StarterSword2.Attack, StarterSword2.Rarity)
}

func getRandomNumber(UpperBoundInt:Int) -> Int {
    let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound:UpperBoundInt)
    return randomNumber
}
