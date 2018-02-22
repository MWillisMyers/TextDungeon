//
//  battle.swift
//  TextDungeon
//
//  Created by Metalface on 2/16/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import Foundation
import os.log

extension ViewController {
    func enemyEngaged(enemy:Enemy) {
        printOut(text: "A \(enemy.Name) has engaged you!")
        state = states.isInBattle
        currentEnemy = enemy
        if char.activeCharacter == char.charBarbarian {
            enemyDistance = 0
            printOut(text: "Your barbarian character engaged at close range!")
        } else { //char.activeCharacter != char.charBarbarian  pretty sure i dont need this
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
        default:
            printOut(text: "Unknown battle command.")
        }
    }
    func attackEnemy() {
        if currentEnemy.Speed >= char.activeCharacter.Speed {
            doTurn()
            // currentEnemy.Health -= char.activeCharacter.Attack // add attack values from weapon 
        }
        
    }
    func doTurn() { //what happens in a turn? the enemy attacks + gets closer
        if enemyDistance == 0 {
            char.activeCharacter.Health -= Int(currentEnemy.Attack)
            printOut(text: "The enemy hit you for \(Int(currentEnemy.Attack)), your \(char.activeCharacter.Name)'s health is \(char.activeCharacter.Health)")
        } else if enemyDistance > 0 {
            enemyDistance -= currentEnemy.Speed
            printOut(text: "The enemy distance is \(enemyDistance)")
        } else {
            print("This if statement did jack shit...")
        }
    }
}
