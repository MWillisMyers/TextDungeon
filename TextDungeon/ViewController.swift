//
//  ViewController.swift
//  TextDungeon
//
//  Created by Matt Myers on 1/29/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import UIKit
import os.log


class ViewController: UIViewController {

    
    //define stored properties
    var sentText:String?
    var inventory = inv() //define inventory instance
    var char = players() //player instance
    var state:states = .isInEvironment
    var previousState:states = .isInEvironment
    //battle properties
    var currentEnemy:Enemy!
    var enemyDistance:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Debug()
        char.activeCharacter = char.charRanger // for debugging purposes
        enemyDebug() //enemy debug function
        if let savedInv = inventory.loadInv() { //loads inventory, need a way for this to work on characters
            print("loading saved inv")
            inventory.WeaponArray += savedInv
        } else {
            print("loading sample swords")
            loadSampleSwords()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //outlets
    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var OutputField: UITextView!
    
    
    //IBAction Funcs
    @IBAction func sendCommand(_ sender: UIButton) {
        let sentText:String = commandField.text!
        printOut(text: sentText) //prints command sent
        checkCommand(text: sentText) //sends command to base command checker
    }
    
    @IBAction func saveInvButton(_ sender: UIButton) {
        inventory.saveInv()
    }
    @IBAction func AddWeaponButton(_ sender: UIButton) {
        addWeapon()
    }
    
    //Regular Functions
    
    //Prints to the output UITextField
    func printOut(text:String) {
        OutputField.insertText(text+"\n")
        commandField.text = ""
        let point = CGPoint(x: 0.0, y: (OutputField.contentSize.height - OutputField.bounds.height))
        OutputField.setContentOffset(point, animated: true)
    }
    
    
    func checkCommand(text:String) {
        switch state {
        case .isInEvironment:
            print("current state is environment, sending command over there...")
            checkEnvironmentCommands(input: text)
        case .isInBattle:
            print("current state is battling, sending command over there...")
            checkBattleCommands(input: text)
        case .isInCharacter:
            print("current state is character menu, sending command over there...")
            checkCharacterMenuCommands(input: text)
        case .isInInventory:
            print("current state is inventory menu, sending command over there...")
            checkInventoryCommands(input: text)
        }
        
    }
    
    func checkEnvironmentCommands(input:String) { // the command written will be passed through here if the player is in the "default environment"
        switch input {
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
            printOut(text: "Unknown Command. Type 'help'. You're in the environment")
        }
    }
    
    func checkCharacterMenuCommands(input:String) { //currently can only switch between ranger and barbarian
        switch input {
        case "back", "return":
            state = previousState
            print("previous state:",previousState)
            printOut(text:"Returning from character menu...")
        case "switch barb", "sw barb", "switch barbarian", "sw barbarian":
            char.activeCharacter = char.charBarbarian
            printOut(text: "Your active character is now Barbarian")
        case "switch ranger", "sw ranger", "sw rang", "switch rang":
            char.activeCharacter = char.charRanger
            printOut(text: "Your active character is now Ranger")
        default:
            printOut(text: "Unknown Command. Type 'help' You're in the character menu")
        }
    }
    
    // check inventory commands is in the inventory.swift file, look over there
    
    func loadSampleSwords() {
        let Sword1 = Sword(material: 0)
        let Sword2 = Sword(material: 5)
        inventory.WeaponArray += [Sword1, Sword2]
    }
    
    func addWeapon() {
        let chooser = getRandomNumber(upper: 3, lower: 1)
        switch chooser {
        case 1:
            inventory.WeaponArray += [randCommonSword()]
        case 2:
            inventory.WeaponArray += [randCommonDagger()]
        default:
            inventory.WeaponArray += [randUncommonSword()]
        }
    }
    
    //define states of play, that allow certain commands that only run in a state, such as delete item or attack. You can't attack unless you're battling
    enum states {
        case isInBattle
        case isInEvironment
        case isInInventory
        case isInCharacter
    }
}




