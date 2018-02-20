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

