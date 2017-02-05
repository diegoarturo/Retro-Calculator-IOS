//
//  ViewController.swift
//  retroCalc
//
//  Created by Diego Torres on 1/13/17.
//  Copyright © 2017 UNAMunam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    

    
    enum Operation:String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outPutLbl :UILabel!
    var btnSound: AVAudioPlayer!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn",ofType:"wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl as URL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outPutLbl.text = runningNumber
    }

    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(op: Operation.Divide)
        
    }

    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(op: Operation.Multiply)
        
    }

    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(op: Operation.Subtract)
        
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(op: Operation.Add)
        
    }
    

    @IBAction func onEqualsPressed(_ sender: Any) {
        processOperation(op: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        clearing()
    }
    
    func processOperation(op:Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outPutLbl.text = result
                currentOperation = op
            }
            
            
        }else{
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func clearing(){
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        outPutLbl.text = "0"
        
    }
    
    
}

