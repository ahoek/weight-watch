//
//  ViewController.swift
//  Gewicht
//
//  Created by Arthur Hoek on 13-08-15.
//  Copyright (c) 2015 Arthur Hoek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let healthManager:HealthManager = HealthManager()
	
	func authorizeHealthKit()
	{
		
		healthManager.authorizeHealthKit { (authorized,  error) -> Void in
			if authorized {
				//println("HealthKit authorization received.")
			}
			else
			{
				//println("HealthKit authorization denied!")
				if error != nil {
					//println("\(error)")
				}
			}
		}

	}
	
	@IBAction func setAuth() {
		authorizeHealthKit()
	}
	
	@IBAction func setWeight(sender: UIButton) {
		healthManager.storeWeight(90.1);
		

	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		authorizeHealthKit()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
