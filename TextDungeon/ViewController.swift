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
var inventory = inv()
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Do stuff here.")
        Debug()
        if let savedInv = inventory.loadInv() {
            inventory.SwordArray! += savedInv
        } else {
            loadSampleSwords()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//At the age of 3, my uncle and I played hide and seek. This was a mistake. Our annual game of "hide and seek", became known as 'Naked and Afraid' instead. I am still scarred from these experiences and now I play Torbjorn on attack to hide my trust issues and pain.
    //outlets
    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var OutputField: UITextView!
    @IBAction func sendCommand(_ sender: UIButton) {
        let sentText:String = commandField.text!
        printOut(text: sentText)
        checkCommand()
    }
    @IBAction func saveInvButton(_ sender: UIButton) {
        inventory.saveInv()
    }
    
    
    
    
    func printOut(text:String) {
        OutputField.insertText(text+"\n")
        commandField.text = ""
        let point = CGPoint(x: 0.0, y: (OutputField.contentSize.height - OutputField.bounds.height))
        OutputField.setContentOffset(point, animated: true)
    }
    
    func checkCommand() {
        switch sentText {
        case "inventory"?:
            let invString:String = inventory.ShowInv()
            printOut(text: invString)
        default:
            return
            //inventory() for later >:D
        }
    }
    
    func loadSampleSwords() {
        let Sword1 = Sword(material: 0)
        let Sword2 = Sword(material: 5)
        inventory.SwordArray! += [Sword1, Sword2]
    }
    
    }




