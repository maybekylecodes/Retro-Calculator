//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Kyle Jennings on 1/18/16.
//  Copyright © 2016 Kyle Jennings. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    //Outlets
    
    @IBOutlet weak var outPutLabel: UILabel!
    
    
    
    //Variables
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
        try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn:UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outPutLabel.text = runningNumber
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        if runningNumber != "" {
        processOperation(Operation.Divide)
        }
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        playSound()
        if runningNumber != "" {
        processOperation(Operation.Multiply)
        }
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        playSound()
        if runningNumber != "" {
        processOperation(Operation.Subtract)
        }
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        if runningNumber != "" {
        processOperation(Operation.Add)
    }
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        playSound()
        if runningNumber != "" {
        processOperation(currentOperation)
        }
    }
    @IBAction func clearButton(sender: AnyObject) {
        playSound()
        runningNumber = ""
        outPutLabel.text = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            //A user selected an operator, but then selected another operator without
            //first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outPutLabel.text = result
            }
            
            
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    func playSound() {
        if btnSound.playing {
        btnSound.stop()
    }
        btnSound.play()
    }
    
}

