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

	var userIsInTheMiddleOfTypingANumber = false
	
	// Change textlabel
	var enteredWeight = "0" {
		didSet {
			enteredWeightLabel.setText(enteredWeight)
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
			let length = count(enteredWeight)
			if length > 0 {
				enteredWeight = dropLast(enteredWeight)
			}
			if length == 1 {
				userIsInTheMiddleOfTypingANumber = false
				enteredWeight = "0"
			}
		}
	}
	
	@IBAction func submitWeight() {
		//enteredWeight = "0"
		sendMessageToParentAppWithString(enteredWeight)
	}
	
	func appendDigit(digit: String) {
		if userIsInTheMiddleOfTypingANumber {
			// Do not allow two decimal points in number
			if digit == "." && enteredWeight.rangeOfString(".") == nil {
				enteredWeight = enteredWeight + "."
			} else {
				enteredWeight = enteredWeight + digit
			}
		} else {
			// First digit
			if digit == "." {
				enteredWeight = "0."
			} else {
				enteredWeight = digit
			}
			userIsInTheMiddleOfTypingANumber = true
		}
		
	}
	
	func sendMessageToParentAppWithString(messageText: String) {
		let infoDictionary = ["message" : messageText]
		
		WKInterfaceController.openParentApplication(infoDictionary) {
			(replyDictionary, error) -> Void in
			
			if let castedResponseDictionary = replyDictionary as? [String: String],
				responseMessage = castedResponseDictionary["message"]
			{
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
