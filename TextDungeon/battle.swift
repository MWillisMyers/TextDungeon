//
//  battle.swift
//  TextDungeon
//
//  Created by Metalface on 2/16/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import Foundation
import os.log

extension ViewController { // this whole thing is just a collection of functions relating to battling enemies
    func enemyEngaged(enemy:Enemy) {
        printOut(text: "A \(enemy.Name) has engaged you!")
        state = states.isInBattle
        currentEnemy = enemy
        if char.getActiveCharacterString() == "Barbarian" || char.getActiveCharacterString() == "Preist" {
            enemyDistance = 0
            printOut(text: "Your \(char.activeCharacter.Name) engaged at close range!")
        } else {
            //enemyDistance = char.activeCharacter.skilltree.engagedistance //need a skill tree to do that one, hehe
            enemyDistance = 50
            printOut(text: "Your \(char.activeCharacter.Name) engaged at a range of \(enemyDistance) meters")
        }
    }
    
    func checkBattleCommands(input:String) {
        switch input {
        case "atk", "attack":
            attackEnemy()
        case "inventory", "inv":
            printInventory()
            previousState = state //sets the previous state so we can go back to it, this is required for all cases
            state = states.isInInventory //set the state to the inventory, also required for all cases
            print("setting state to inv")
        case "characters", "char":
            printStats()
            previousState = state
            state = states.isInCharacter //set state to character
            print("setting state to char")
        case "approach", "get closer", "close in":
            enemyDistance = 0
            printOut(text: "You waited for the enemy to engage you in close range.")
            printOut(text: "Your range is now 0m.")
        default:
            printOut(text: "Unknown battle command.")
        }
    }
    func attackEnemy() {
        if currentEnemy.Speed >= char.activeCharacter.Speed {
            doTurn()
            //calculateDamage()
        } else {
            calculateDamage()
            doTurn()
        }
        
    }
    func doTurn() { //what happens in a turn? the enemy attacks + gets closer
        if enemyDistance == 0 {
            checkCharDeath()
            char.activeCharacter.Health -= Int(currentEnemy.Attack)
            printOut(text: "The enemy hit you for \(Int(currentEnemy.Attack)), your \(char.activeCharacter.Name)'s health is \(char.activeCharacter.Health)")
        } else if enemyDistance > 0 {
            checkCharDeath()
            enemyDistance -= currentEnemy.Speed
            printOut(text: "The enemy distance is \(enemyDistance)m.")
        } else {
            print("This if statement did jack shit...")
        }
    }
    func checkCharDeath() { //you okay bro?
        if char.activeCharacter.Health < 1 {
            let chooser = getRandomNumber(upper: 3, lower: 0)
            char.activeCharacter.isDead = true
            printOut(text: "Your \(char.activeCharacter.Name) has been killed! Switching to random character...")
            switch chooser {
            case 0: //barb
                if char.charBarbarian.isDead == false {
                    char.activeCharacter = char.charBarbarian
                } else {
                    char.activeCharacter = char.charRanger
                    checkCharDeath()
                }
            case 1: //ranger
                if char.charRanger.isDead == false {
                    char.activeCharacter = char.charRanger
                } else {
                    char.activeCharacter = char.charSorcerer
                    checkCharDeath()
                }
            case 2: //sorcerer
                if char.charSorcerer.isDead == false {
                    char.activeCharacter = char.charSorcerer
                } else {
                    char.activeCharacter = char.charPriest
                    checkCharDeath()
                }
            case 3: //preist
                if char.charPriest.isDead == false {
                    char.activeCharacter = char.charPriest
                } else {
                    char.activeCharacter = char.charBarbarian
                    checkCharDeath()
                }
            default:
                print("game machine br0ke")
            }
            
        }
        if currentEnemy.Health < 1 {
            printOut(text: "You killed the \(currentEnemy.Name)!")
            state = .isInEvironment
        }
    }
    
    func barbarianDamageModel() {
        currentEnemy.Health -= Int(char.charBarbarian.Power * Double(char.activeCharacter.equippedWeapon!.attack))
        printOut(text: "You hit the enemy for \(Int(char.charBarbarian.Power * Double(char.activeCharacter.equippedWeapon!.attack)))")
    }
    
    func calculateDamage() { //currently only has barbarian damage model...
        //check for an equipped weapon if not then just punch the enemy
        if char.activeCharacter.equippedWeapon == nil, enemyDistance <= 0 {
            //currentEnemy.Health -= Int(char.activeCharacter.Attack * Double(char.activeCharacter.Experience) + 1) //char.activeCharacter.Experience seems to be the problem
            currentEnemy.Health -= Int(char.activeCharacter.Attack)
            printOut(text: "You don't have a weapon equipped, so you engage with your fists!")
            printOut(text: "You hit the enemy for \(Int(char.activeCharacter.Attack * Double(char.activeCharacter.Experience) + 1))")
        } else if char.activeCharacter.equippedWeapon == nil, enemyDistance > 0 {
            printOut(text: "You don't have a ranged weapon, so you simply wait for the enemy to approach.")
        } else if char.activeCharacter.equippedWeapon != nil {
            switch char.activeCharacter.Name {
            case "Barbarian":
                barbarianDamageModel()
            default:
                printOut(text: "You just broke my game you asshole -.-")
            }
        }
    }
}


