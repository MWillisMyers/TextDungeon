//
//  Inventory.swift
//  TextDungeon
//
//  Created by install on 1/31/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

/*
 We do inventory stuff here.
 TODO: Finish damage models for all characters.
 add weapons for all characters
 add weapon equpping for all characters.
 
*/

import Foundation
import CoreData
import UIKit
import os.log






// code for an instance in the ViewController. Most of these functions will be used in the viewcontroller
struct inv {
    var WeaponArray:[Weapon] = []
    func saveInv() {
        do {
            let codedData = try PropertyListEncoder().encode(WeaponArray) //codes the data using Codable
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(codedData, toFile: Weapon.ArchiveURL.path) //archives it using NSArchiver
            print(isSuccessfulSave ? "save good" : "save not good")
        } catch {
            print("Save Failed")
        }
    }
    
    func loadInv() -> [Weapon]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Weapon.ArchiveURL.path) as? Data else { return nil } //gets coded data from NSUnarchiver
        do {
            let uncodedData = try PropertyListDecoder().decode([Weapon].self, from: data) //decodes it using Codable
            return uncodedData
        } catch {
            print("inv retrieve failed")
            return nil
        }
    }
    func ShowInv() -> String {
        return String(describing: WeaponArray)
    }
    
}

extension ViewController {
    func checkInventoryCommands(input:String) {
        if isEquippingWeapon == true {
            equipWeapon(input: input)
        } else {
            switch input {
            case "back", "return":
                state = previousState
                print("previous state:",previousState)
                printOut(text:"Returning from inventory menu...")
            case "equip":
                isEquippingWeapon = true
                printOut(text: "Type character followed by the number identifer of the weapon you wish to equip.")
            default:
                printOut(text: "Unknown Command. Type 'help'. You're in the inventory.")
                return
            }
        }
    }
    
    func equipWeapon(input:String) { //main equipping weapon function
        var command = input.components(separatedBy: " ") //gets inputted command and seperates it into 2 array elements
        print(command)
        if command[0] == "back" {
            isEquippingWeapon = false
            printInventory()
            return
        }
        
        command.append("0") // appends an element on the array to keep the complier happy if the user is stupid
        let weapn = inventory.WeaponArray[safe:Int(command[1])!] //this custom checker i found on google instead of throwing an error returns a nil
        if weapn == nil { //checks if returned weapon is a nil
            printOut(text: "That number doesn't correspond to any weapon")
            return
        }
        
        switch command[0] { //switches first item in command array
        case "barb":
            let ret:Bool = switchWeaponBarbarian(weap:weapn!) // func returns true or false if it worked, if it did then equip the weapon
            if ret == true {
                inventory.WeaponArray.remove(at:Int(command[1])!)// if it did work, remove the weapon from the inventory
                printOut(text: "Weapon sucessfully switched to \(char.charBarbarian.equippedWeapon!)")
            } else {
                printOut(text: "Weapon not switched")
            }
        case "rang":
            let ret:Bool = switchWeaponRanger(weap:weapn!)
            if ret == true {
                inventory.WeaponArray.remove(at:Int(command[1])!)// if it did work, remove the weapon from the inventory
                printOut(text: "Weapon sucessfully switched to \(char.charRanger.equippedWeapon!)")
            } else {
                printOut(text: "Weapon not switched")
            }
        default:
            print("broke game")
        }
    }
    
    func printInventory() {
        printOut(text: "Name | Attack | Weight") // Inventory header
        var counter = 0
        for str in inventory.WeaponArray {
            printOut(text: String(counter) + seperator + str.name + seperator + String(describing: str.attack) + seperator + String(describing: str.weight)) //Prints inventory array
            counter += 1
        }
        counter = 0
    }
    //first ive got to append his existing equipped weapon into the inv, then take the weapon specified out of the inv.
    func switchWeaponBarbarian(weap:Weapon) -> Bool {
        if weap.weaponType == weaponTypes.Sword { // || weap is Mace for later
            if char.charBarbarian.equippedWeapon != nil {
                inventory.WeaponArray.append(char.charBarbarian.equippedWeapon!)
                char.charBarbarian.equippedWeapon = weap
            } else {
                char.charBarbarian.equippedWeapon = weap
            }
            return true
        } else {
            printOut(text: "Equip a sword or mace for barbarian.")
            return false
        }
    }
    
    func switchWeaponRanger(weap:Weapon) -> Bool {
        if weap.weaponType == weaponTypes.Dagger { // || weap is Mace for later
            if char.charRanger.equippedWeapon != nil {
                inventory.WeaponArray.append(char.charRanger.equippedWeapon!)
                char.charRanger.equippedWeapon = weap
            } else {
                char.charRanger.equippedWeapon = weap
            }
            return true //will return a true or false value to specify if the switchWeapon worked or not
        } else {
            printOut(text: "Equip a Dagger or Bow for the Ranger.")
            return false
        }
    }
}
extension Array { //safe array checker i got from google
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
