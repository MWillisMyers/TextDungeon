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
    }
}
