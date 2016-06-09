//
//  ViewController.swift
//  RetroCalculatorUpdated
//
//  Created by Sai Pratap Koppolu  on 09/06/16.
//  Copyright © 2016 KSP. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Percentage = "%"
        case Empty = ""
        
    }
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    var btnSound = AVAudioPlayer()
    
    @IBOutlet weak var outputLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let url = NSURL(fileURLWithPath: path!)
        
        do {
        
            try btnSound = AVAudioPlayer(contentsOfURL: url)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNumberPressed(sender: UIButton) {
        
        runningNumber = runningNumber + "\(sender.tag)"
        outputLbl.text = runningNumber
        playSound()
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(op: Operation) {
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
            
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Divide {
                
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }
                
            if currentOperation == Operation.Multiply {
                    
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }

            if currentOperation == Operation.Add {
                    
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
             
            if currentOperation == Operation.Subtract {
                    
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
                
            if currentOperation == Operation.Percentage {
                    
                result = "\(Double(leftValStr)! * Double(rightValStr)! / 100)"
            }

                leftValStr = result
                outputLbl.text = result

            }
            currentOperation = op
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        playSound()
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        
        processOperation(Operation.Divide)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        
        processOperation(Operation.Add)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
       
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onPercentagePressed(sender: AnyObject) {
        
        processOperation(Operation.Percentage)
    }
   
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    @IBAction func onClearButtonPressed(sender: AnyObject) {
        
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
        playSound()
        
    }
    
}

