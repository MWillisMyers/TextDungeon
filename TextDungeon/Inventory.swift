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







struct inv {
    var SwordArray:[Sword]?
    mutating func saveInv() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(SwordArray, toFile: Weapon.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("inv saved good", log: OSLog.default, type: .debug)
        } else {
            os_log("inv not saved", log: OSLog.default, type: .error)
        }
    }
    
   mutating func loadInv() -> [Sword]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Weapon.ArchiveURL.path) as? [Sword]
    }
    func ShowInv() -> String {
        print(SwordArray)
        return String(describing: SwordArray)
    }
    
}

