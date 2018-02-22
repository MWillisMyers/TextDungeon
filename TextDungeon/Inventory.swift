//
//  Inventory.swift
//  TextDungeon
//
//  Created by install on 1/31/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

/*
 We do inventory stuff here.
*/

import Foundation
import CoreData
import UIKit
import os.log






// code for an instance in the ViewController. Most of these functions will be used in the viewcontroller
struct inv {
    var WeaponArray:[Weapon] = []
    func saveInv() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(WeaponArray, toFile: Weapon.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("inv saved good", log: OSLog.default, type: .debug)
        } else {
            os_log("inv not saved", log: OSLog.default, type: .error)
        }
    }
    
    func loadInv() -> [Weapon]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Weapon.ArchiveURL.path) as? [Weapon]
    }
    func ShowInv() -> String {
        return String(describing: WeaponArray)
    }
    
}

extension ViewController {
    func checkInventoryCommands(input:String) {
        switch input {
        case "back", "return":
            state = previousState
            print("previous state:",previousState)
            printOut(text:"Returning from inventory menu...")
        default:
            printOut(text: "Unknown Command. Type 'help'. You're in the inventory.")
            return
        }
    }
    func printInventory() {
        printOut(text: "Name | Attack | Weight") // Inventory header
        for str in inventory.WeaponArray {
            printOut(text:str.name + seperator + String(describing: str.attack) + seperator + String(describing: str.weight)) //Prints inventory array
        }
    }
}
