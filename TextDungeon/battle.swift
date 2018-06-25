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
        updateButtons()
        if char.playerVar.getActiveCharacterString() == "Barbarian" || char.playerVar.getActiveCharacterString() == "Preist" {
            enemyDistance = 0
            printOut(text: "Your \(char.playerVar.activeCharacter.Name) engaged at close range!")
        } else {
            //enemyDistance = char.playerVar.activeCharacter.skilltree.engagedistance //need a skill tree to do that one, hehe
            enemyDistance = 50
            printOut(text: "Your \(char.playerVar.activeCharacter.Name) engaged at a range of \(enemyDistance) meters")
        }
        
    }
    @objc func returnFromAttack() {
        updateButtons()
    }
    
    @objc func closeDistance() {
        enemyDistance = 0
        doTurn()
    }

    
    @objc func attackEnemy() {
        //if char.playerVar.activeCharacter.Stamina =< 
        if currentEnemy.Speed >= char.playerVar.activeCharacter.Speed {
            doTurn()
            calculateDamage()
        } else {
            calculateDamage()
            doTurn()
        }
    }
    
    @objc func engageAttack() {
        if char.playerVar.activeCharacter.equippedWeapon == nil {
            setButtonTitles(bt1: "Punch", bt2: "Back", bt3: "", bt4: "")
            chosenAttack = 1
            setAction1(#selector(attackEnemy))
            setAction2(#selector(returnFromAttack))
        } else {
            switch char.playerVar.activeCharacter {
            case is barbarian:
                setButtonTitles(bt1: "Light Slash", bt2: "Heavy Slash", bt3: "Charged Blow", bt4: "Block")
                chosenAttack = 1
                setAction1(#selector(attackEnemy))
            case is ranger:
                setButtonTitles(bt1: "Shoot", bt2: "", bt3: "", bt4: "")
            case is sorcerer:
                setButtonTitles(bt1: "Spell 1", bt2: "Spell 2", bt3: "Spell 3", bt4: "Melee")
            case is preist:
                setButtonTitles(bt1: "Heal", bt2: "Shield", bt3: "Slash", bt4: "")
            default:
                setButtonTitles(bt1: "Unknown type", bt2: "", bt3: "", bt4: "")
            }
        }
    }
    
    func doTurn() { //what happens in a turn? the enemy attacks + gets closer
        if enemyDistance == 0 {
            checkCharDeath()
            char.playerVar.activeCharacter.Health -= Int(currentEnemy.Attack)
            printOut(text: "The enemy hit you for \(Int(currentEnemy.Attack)), your \(char.playerVar.activeCharacter.Name)'s health is \(char.playerVar.activeCharacter.Health)")
        } else if enemyDistance > 0 {
            checkCharDeath()
            enemyDistance -= currentEnemy.Speed
            printOut(text: "The enemy distance is \(enemyDistance)m.")
        } else {
            print("if statement broke. enemy distance is \(enemyDistance)")
        }
        char.savePlayers()
    }
    func checkCharDeath() { //you okay bro?
        if char.playerVar.activeCharacter.Health < 1 {
            let chooser = getRandomNumber(upper: 3, lower: 0)
            char.playerVar.activeCharacter.isDead = true
            printOut(text: "Your \(char.playerVar.activeCharacter.Name) has been killed! Switching to random character...")
            switch chooser {
            case 0: //barb
                if char.playerVar.charBarbarian.isDead == false {
                    char.playerVar.activeCharacter = char.playerVar.charBarbarian
                } else {
                    char.playerVar.activeCharacter = char.playerVar.charRanger
                    checkCharDeath()
                }
            case 1: //ranger
                if char.playerVar.charRanger.isDead == false {
                    char.playerVar.activeCharacter = char.playerVar.charRanger
                } else {
                    char.playerVar.activeCharacter = char.playerVar.charSorcerer
                    checkCharDeath()
                }
            case 2: //sorcerer
                if char.playerVar.charSorcerer.isDead == false {
                    char.playerVar.activeCharacter = char.playerVar.charSorcerer
                } else {
                    char.playerVar.activeCharacter = char.playerVar.charPriest
                    checkCharDeath()
                }
            case 3: //preist
                if char.playerVar.charPriest.isDead == false {
                    char.playerVar.activeCharacter = char.playerVar.charPriest
                } else {
                    char.playerVar.activeCharacter = char.playerVar.charBarbarian
                    checkCharDeath()
                }
            default:
                print("Random Character to switch to broke")
            }
            
        }
        if currentEnemy.Health < 1 {
            printOut(text: "You killed the \(currentEnemy.Name)!")
            state = .isInEvironment
            updateButtons()
        }
    }
    
    @objc func barbarianDamageModel() {
        switch chosenAttack {
        case 1:
            currentEnemy.Health -= Int(char.playerVar.charBarbarian.Power * Double(char.playerVar.activeCharacter.equippedWeapon!.attack)) //enemyhealth - power * weaponAttack
            
            printOut(text: "You hit the enemy for \(Int(char.playerVar.charBarbarian.Power * Double(char.playerVar.activeCharacter.equippedWeapon!.attack)))")
        default:
            printOut(text: "Not implemeted")
        }
    }
    
    func calculateDamage() { //currently only has barbarian damage model...
        //check for an equipped weapon if not then just punch the enemy
        if char.playerVar.activeCharacter.equippedWeapon == nil, enemyDistance <= 0 {
            currentEnemy.Health -= Int(char.playerVar.activeCharacter.Attack * Double(char.playerVar.activeCharacter.Experience) + 1) //char.playerVar.activeCharacter.Experience seems to be the problem
            currentEnemy.Health -= Int(char.playerVar.activeCharacter.Attack)
            printOut(text: "You don't have a weapon equipped, so you engage with your fists!")
            printOut(text: "You hit the enemy for \(Int(char.playerVar.activeCharacter.Attack * Double(char.playerVar.activeCharacter.Experience) + 1))")
        } else if char.playerVar.activeCharacter.equippedWeapon == nil, enemyDistance > 0 {
            printOut(text: "You don't have a ranged weapon, so you simply wait for the enemy to approach.")
        } else if char.playerVar.activeCharacter.equippedWeapon != nil {
            switch char.playerVar.activeCharacter.Name {
            case "Barbarian":
                barbarianDamageModel()
            default:
                printOut(text: "Somehow weapon equipped states broke")
            }
        }
    }
}


