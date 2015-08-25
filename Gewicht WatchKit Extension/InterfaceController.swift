//
//  InterfaceController.swift
//  Gewicht WatchKit Extension
//
//  Created by Arthur Hoek on 13-08-15.
//  Copyright (c) 2015 Arthur Hoek. All rights reserved.
//
// →


import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

	//let healthManager:HealthManager = HealthManager()

	
	@IBOutlet weak var enteredWeightLabel: WKInterfaceLabel!

	var userIsInTheMiddleOfTypingANumber = false {
		didSet {
			if userIsInTheMiddleOfTypingANumber {
				enteredWeightLabel.setTextColor(UIColor.whiteColor())
			} else {
				enteredWeightLabel.setTextColor(UIColor.greenColor())
			}
		}
	}
	
	// Change textlabel
	var weight = "0" {
		didSet {
			//let weightFormatter = NSMassFormatter()
			enteredWeightLabel.setText(weight)
		}
	}
	
	@IBAction func enterZero() {
		appendDigit("0")
	}
	@IBAction func enterOne() {
		appendDigit("1")
	}
	@IBAction func enterTwo() {
		appendDigit("2")
	}
	@IBAction func enterThree() {
		appendDigit("3")
	}
	@IBAction func enterFour() {
		appendDigit("4")
	}
	@IBAction func enterFive() {
		appendDigit("5")
	}
	@IBAction func enterSix() {
		appendDigit("6")
	}
	@IBAction func enterSeven() {
		appendDigit("7")
	}
	@IBAction func enterEight() {
		appendDigit("8")
	}
	@IBAction func enterNine() {
		appendDigit("9")
	}
	
	@IBAction func enterDecimalPoint() {
		appendDigit(".")
	}
	
	
	@IBAction func backspace() {
		if userIsInTheMiddleOfTypingANumber {
			
			// remove rightmost digit
			let length = count(weight)
			if length > 0 {
				weight = dropLast(weight)
			}
			if length == 1 {
				userIsInTheMiddleOfTypingANumber = false
				weight = "0"
			}
		}
	}
	
	@IBAction func submitWeight() {
		sendMessageToParentApp((weight as NSString).doubleValue)
	}
	
	func appendDigit(digit: String) {
		if userIsInTheMiddleOfTypingANumber {
			// Do not allow two decimal points in number
			if digit == "." && weight.rangeOfString(".") == nil {
				weight = weight + "."
			} else {
				weight = weight + digit
			}
		} else {
			// First digit
			if digit == "." {
				weight = "0."
			} else {
				weight = digit
			}
			userIsInTheMiddleOfTypingANumber = true
		}
		
	}
	
	func sendMessageToParentApp(message: Double) {
		let infoDictionary = ["message" : message]
		
		WKInterfaceController.openParentApplication(infoDictionary) {
			(replyDictionary, error) -> Void in
			
			if let castedResponseDictionary = replyDictionary as? [String: String],
				responseMessage = castedResponseDictionary["message"]
			{
				self.userIsInTheMiddleOfTypingANumber = false
				println(responseMessage)
			}
		}
	}
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
