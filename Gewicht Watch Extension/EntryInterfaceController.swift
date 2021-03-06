//
//  InterfaceController.swift
//  Gewicht WatchKit Extension
//
//  Created by Arthur Hoek on 13-08-15.
//  Copyright (c) 2015 Arthur Hoek. All rights reserved.
//
// Watch OS 2


import WatchKit
import Foundation
import WatchConnectivity


class EntryInterfaceController: WKInterfaceController {
	
	let healthManager:HealthManager = HealthManager()
	
	var locale:NSLocale {
		//return NSLocale(localeIdentifier: "nl_NL")
		return NSLocale.currentLocale()
	}

	var formatter:NSNumberFormatter {
		let numberFormatter = NSNumberFormatter()
		numberFormatter.locale = locale
		return numberFormatter
	}
	
	var decimalSeparator:String {
		return formatter.decimalSeparator
	}
	
	@IBOutlet weak var enteredWeightLabel: WKInterfaceLabel!
	
	@IBOutlet weak var statusLabel: WKInterfaceLabel!
	
	var userIsInTheMiddleOfTypingANumber = false {
		didSet {
			if userIsInTheMiddleOfTypingANumber || weight == "0" {
				statusLabel.setText("");
				enteredWeightLabel.setTextColor(UIColor.whiteColor())
			} else {
				// todo: move to weight sent sucess
				statusLabel.setText("👍");
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


	// MARK: - Button presses
	
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
		appendDigit(decimalSeparator)
	}	
	
	@IBAction func backspace() {
		if userIsInTheMiddleOfTypingANumber {
			
			// remove rightmost digit
			let length = weight.characters.count
			if length > 0 {
				weight = String(weight.characters.dropLast())
			}
			if length == 1 {
				userIsInTheMiddleOfTypingANumber = false
				weight = "0"
			}
		}
	}
	
	@IBAction func submitWeight() {
		enteredWeightLabel.setTextColor(UIColor.orangeColor())
		if let weightNumber = formatter.numberFromString(weight) {
			print(weightNumber.doubleValue)
			healthManager.storeWeight(weightNumber.doubleValue)
			WKInterfaceDevice.currentDevice().playHaptic(.Success)
			self.userIsInTheMiddleOfTypingANumber = false
		}
	}
	
	func appendDigit(digit: String) {
		if userIsInTheMiddleOfTypingANumber {
			// Do not allow two decimal points in number
			if digit != decimalSeparator || weight.rangeOfString(decimalSeparator) == nil {
				weight += digit
			}
		} else {
			// First digit
			if digit == decimalSeparator {
				weight = "0" + decimalSeparator
			} else {
				weight = digit
			}
			userIsInTheMiddleOfTypingANumber = true
		}
	}
	
	// not used anymore, health data is stored directly in watch
	func sendMessageToParentApp(message: Double) {
		print("send message \(message)")
		if WCSession.defaultSession().reachable == true {
			
			let requestValues = ["message" : message]
			let session = WCSession.defaultSession()
			
			session.sendMessage(requestValues, replyHandler: { reply in
				print("success");
				
				self.userIsInTheMiddleOfTypingANumber = false
				}, errorHandler: { error in
					print("error: \(error)")
			})
		}
	}
	
	// MARK: -  Life cycle
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		
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
