//
//  ViewController.swift
//  TextDungeon
//
//  Created by Matt Myers on 1/29/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//
/*
 Full Todo:
 Finish damage models for all characters.
 add weapons for all characters <-----
 add weapon equpping for all characters.
 Skill Tree / points / experience
 Character Attacks
 Ranger's Doggo
 Priest and Sorcerer Functionality - such as add them to printstats
 define each enemy type
 add enemy identifers and the sprites to go with them - UIImage probably
 Maybe make boss subclass...
 durability
 magical weapons, like staffs, books.
 Items, potions, etc...
*/
import UIKit
import os.log


class ViewController: UIViewController {

    
    //define stored properties
    var sentText:String?
    var inventory = inv() //define inventory instance
    var char = playerWrapper()
    var state:states = .isInEvironment
    var previousState:states = .isInEvironment
    var isEquippingWeapon = false //for inv 
    //battle properties
    var currentEnemy:Enemy!
    var enemyDistance:Int = 0
    //button var
    var buttonActionSetter = buttonActions()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        enemyDebug() //enemy debug function
        if let savedInv = inventory.loadInv() { //loads inventory
            print("loading saved inv")
            inventory.WeaponArray += savedInv
        } else {
            print("loading sample swords")
            loadSampleSwords()
        }
        if let loadedPlayers = char.loadPlayers() { // loads players
            print("loadedHealth = \(loadedPlayers.charBarbarian.Health)")
            print("loadedAttack = \(loadedPlayers.charBarbarian.Attack)")
            char.playerVar = loadedPlayers
        } else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //outlets
    @IBOutlet weak var OutputField: UITextView!
    
    @IBOutlet weak var Action1Outlet: UIButton!
    @IBOutlet weak var Action2Outlet: UIButton!
    @IBOutlet weak var Action3Outlet: UIButton!
    @IBOutlet weak var Action4Outlet: UIButton!
    
    
    //IBAction Funcs
    /*
    @IBAction func sendCommand(_ sender: UIButton) {
        let sentText:String = commandField.text!
        printOut(text: sentText) //prints command sent
        checkCommand(text: sentText) //sends command to base command checker
    }
    */
    
    
    @IBAction func Action1(_ sender: UIButton) {
        buttonActionSetter.button1Action()
    }
    

    

    //Regular Functions
    
    //Prints to the output UITextField
    func printOut(text:String) {
        OutputField.insertText(text+"\n")
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
    
    func checkCharacterMenuCommands(input:String) {
        switch input {
        case "back", "return":
            state = previousState
            print("previous state:",previousState)
            printOut(text:"Returning from character menu...")
        case "switch barb", "sw barb", "switch barbarian", "sw barbarian":
            char.playerVar.activeCharacter = char.playerVar.charBarbarian
            printOut(text: "Your active character is now Barbarian")
        case "switch ranger", "sw ranger", "sw rang", "switch rang":
            char.playerVar.activeCharacter = char.playerVar.charRanger
            printOut(text: "Your active character is now Ranger")
        case "switch pr", "sw priest", "sw pr", "switch preist":
            char.playerVar.activeCharacter = char.playerVar.charPriest
            printOut(text: "Your active character is now Priest")
        case "switch sorc", "sw sorcerer", "sw sorc", "switch sorcerer":
            char.playerVar.activeCharacter = char.playerVar.charSorcerer
            printOut(text: "Your active character is now Sorcerer")
        case "save":
            char.savePlayers()
        default:
            printOut(text: "Unknown Command. Type 'help' You're in the character menu")
        }
    }
    
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
    func updateButtons() {
        switch state {
        case .isInBattle:
            setButtonTitles(bt1: "attack", bt2: "approach", bt3: "characters", bt4: "inventory")
            buttonActionSetter.button1Action = attackEnemy()
        case .isInCharacter:
            setButtonTitles(bt1: "switch active", bt2: "back", bt3: "", bt4: "")
        case .isInInventory:
            let ret1 = 1
        case .isInEvironment:
            let ret2 = 2
        }
    }
    func setButtonTitles(bt1:String, bt2:String, bt3:String, bt4:String) {
        Action1Outlet.setTitle(bt1, for: .normal)
        Action2Outlet.setTitle(bt2, for: .normal)
        Action3Outlet.setTitle(bt3, for: .normal)
        Action4Outlet.setTitle(bt4, for: .normal)
    }
    
    
    
    
    
    struct buttonActions {
        var button1Action:()
        var button2Action:()
        var button3Action:()
        var button4Action:()
        
        init() {
           //button1Action = attackEnemy()
        }
        
    
        init(btn1:@escaping () -> Void, btn2:() -> Void) {
            self.button1Action = btn1()
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




