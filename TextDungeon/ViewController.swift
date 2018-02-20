//
//  ViewController.swift
//  TextDungeon
//
//  Created by Matt Myers on 1/29/18.
//  Copyright © 2018 Matt Myers. All rights reserved.
//

import UIKit
import os.log
//define variables
var sentText:String?
var inventory = inv() //define inventory instance
var char = players()
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Debug()
        enemyDebug()
        if let savedInv = inventory.loadInv() {
            inventory.saveInv()
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
    //your gay
    
//At the age of 3, my uncle and I played hide and seek. This was a mistake. Our annual game of "hide and seek", became known as 'Naked and Afraid' instead. I am still scarred from these experiences and now I play Torbjorn on attack to hide my trust issues and pain.
    //outlets
    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var OutputField: UITextView!
    @IBAction func sendCommand(_ sender: UIButton) {
        let sentText:String = commandField.text!
        printOut(text: sentText)
        checkCommand(text: sentText)
    }
    
    
    
    @IBAction func saveInvButton(_ sender: UIButton) {
        inventory.saveInv()
    }
    @IBAction func AddWeaponButton(_ sender: UIButton) {
        addWeapon()
    }
    
    
    func printOut(text:String) {
        OutputField.insertText(text+"\n")
        commandField.text = ""
        let point = CGPoint(x: 0.0, y: (OutputField.contentSize.height - OutputField.bounds.height))
        OutputField.setContentOffset(point, animated: true)
    }
    
    
    func checkCommand(text:String) {
        switch text {
        case "inventory":
           /* for str in inventory.WeaponArray {
                printOut(text:str.name + String(describing: str.attack, str.weight))
            } */
            let nothing = ""
        case "characters":
            printStats()
        default:
            return
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
    
}




