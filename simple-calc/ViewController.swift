//
//  ViewController.swift
//  simple-calc
//
//  Created by Andrew Kan on 10/23/16.
//  Copyright © 2016 Andrew Kan. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet var calculatorDisplay: UITextField!
    @IBOutlet weak var rpnSwitchLabel: UILabel!
    @IBOutlet weak var rpnEnterButton: UIButton!

    
    var input : String = ""
    var inputNumber : Double = 0
    var result : Double = 0
    var currentOp : String = ""
    var operandArray = [Double]()
    var counting : Bool = false
    var averaging : Bool = false
    var factorial : Bool = false
    var count = 0
    var rpnArray = [Double]()
    var rpnMode: Bool = false;
    
    var history: [String] = []
    var calcHistoryString : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentOp = "="
        calculatorDisplay.text = ("\(result)")
        if !rpnMode {
            rpnEnterButton.isHidden = true
        } else {
            rpnEnterButton.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toHistoryView" {
            let historyViewController = segue.destination as! HistoryViewController
            historyViewController.calcHistory = history
        }
    }
    
    @IBAction func rpnSwitch(_ sender: UISwitch) {
        if rpnMode {
            rpnEnterButton.isHidden = true
        } else {
            rpnEnterButton.isHidden = false
        }
        rpnMode = sender.isOn;
    }
    
    @IBAction func buttonInput(_ sender: UIButton) {
        input += sender.titleLabel!.text!
        inputNumber = Double(input)!
        calculatorDisplay.text = ("\(inputNumber)")

    }
    
    @IBAction func rpnEnter(_ sender: UIButton) {
        rpnArray.append(Double(calculatorDisplay.text!)!)
        calculatorDisplay.text = ""
        
        input = ""
        
    }
    
    @IBAction func operationInput(_ sender: UIButton) {
        count += 1
        calcHistoryString += calculatorDisplay.text!

        if rpnMode {
            if rpnArray.count == 2 {
                switch sender.titleLabel!.text! {
                case "+" :
                    result = rpnArray[0] + rpnArray[1]
                    calculatorDisplay.text = ("\(result)")
                case "-" :
                    result = rpnArray[0] - rpnArray[1]
                    calculatorDisplay.text = ("\(result)")
                    
                case "*" :
                    result = rpnArray[0] * rpnArray[1]
                    calculatorDisplay.text = ("\(result)")
                    
                case "/" :
                    result = rpnArray[0] / rpnArray[1]
                    calculatorDisplay.text = ("\(result)")
                    
                case "%" :
                    result = rpnArray[0].truncatingRemainder(dividingBy: rpnArray[1])
                    calculatorDisplay.text = ("\(result)")
                    
                default:
                    print("Wrong button")
                }
                rpnArray = []
            }  else {
                print("Must have two numbers inserted")
            }
            
        } else {
            input = ""
           
            let operation = sender.titleLabel!.text!

         
            switch currentOp {

            case "+" :
                result += inputNumber
            case "-" :
                result -= inputNumber
            case "*" :
                result *= inputNumber
            case "/" :
                result /= inputNumber
            case "%" :
                result = result.truncatingRemainder(dividingBy: inputNumber)
            case "=" :
                
                if counting {
                    result = Double(operandArray.count)
                } else if averaging {
                    var sum: Double = 0
                    for number in operandArray {
                        sum += Double(number)
                    }
                    result = sum / Double(operandArray.count)
                } else if factorial {
                    var fact = 1
                    if operandArray.count == 1 {
                        for number in 1 ... Int(operandArray[0]) {
                            fact *= number
                        }
                    } else {
                        print("Can't calculate Factorial")
                    }
                    result = Double(fact)
                } else {
                    result = inputNumber

            
                }
               
            default : print("error")
                
            }
            if operation != "=" {
                calcHistoryString += " " + operation + " "
            } else {
                calcHistoryString += " = "
                if count == 2 {
                    print(count)
                    calcHistoryString += "\(result)"
                }
                history.append(calcHistoryString)
            }
            

            inputNumber = 0
            calculatorDisplay.text = ("\(result)")
            
            if sender.titleLabel!.text == "=" {
                result = 0
                inputNumber = 0
                input = ""
                operandArray = []
                counting = false
                averaging = false
                factorial = false
                calcHistoryString = ""
                count = 0
                
            }
            currentOp = sender.titleLabel!.text! as String!
        }


    }
    
    @IBAction func multiOperandInput(_ sender: UIButton) {
        if rpnMode {
            input = ""
            let multiOperand = sender.titleLabel!.text!
            switch multiOperand {
            case "Count":
                calculatorDisplay.text = ("\(rpnArray.count)")
                rpnArray = []
                
            case "Avg" :
                var sum: Double = 0
                for number in rpnArray {
                    sum += Double(number)
                }
                result = sum / Double(rpnArray.count)
                calculatorDisplay.text = ("\(result)")
                rpnArray = []
                
                
            case "Fact" :
                if rpnArray.count > 1 {
                    print("Error")
                    return
                } else {
                    var test: Int = 1
                    for number in 1 ... Int(rpnArray[0]) {
                        test *= number
                    }
                    calculatorDisplay.text = ("\(test)")
                    rpnArray = []
                    
                }
            default:
                print("Error")
            }
            
        } else {
            input = ""
            let multiOperand = sender.titleLabel!.text!
            switch multiOperand {
            case "Count":
                counting = true
            case "Avg" :
                averaging = true
            case "Fact" :
                if operandArray.count > 1 {
                    print("Error")
                    return
                } else {
                    factorial = true
                }
            default:
                print("Error")
            }
            operandArray.append(Double(calculatorDisplay.text!)!)
            
        }
    }
}

