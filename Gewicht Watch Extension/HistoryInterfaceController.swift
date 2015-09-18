//
//  HistoryInterfaceController.swift
//  Gewicht
//
//  Created by Arthur Hoek on 17-09-15.
//  Copyright © 2015 Arthur Hoek. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit


class HistoryInterfaceController: WKInterfaceController {
	
	let healthManager:HealthManager = HealthManager()
	// Model
	// TODO: get from healthkit
	
	var history:[HKSample] = [];

	// MARK: - Outlets
	
	@IBOutlet var historyTable: WKInterfaceTable!
	
	
	
	func reloadTable() {
		print("reloading...")
		healthManager.readMostRecentWeight({ (results, error) -> Void in
			if (error != nil) {
				print("Error reading weight from HealthKit Store: \(error.localizedDescription)")
				return;
			}
			print("success loading weights \(results.count)")
			self.history = results;
			
			self.historyTable.setNumberOfRows(self.history.count, withRowType: "HistoryRow")
			
			let formatter = NSDateFormatter()
			//formatter.dateStyle = .MediumStyle
			//formatter.timeStyle = .ShortStyle
			
			formatter.dateFormat = "d MMM H:mm";
			
			var index = 0
			for entry in self.history {
				let weight = entry as? HKQuantitySample;
				let kilograms = weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
				let date = (weight?.startDate)!
				let dateString = formatter.stringFromDate(date)
				
				
				if let row = self.historyTable.rowControllerAtIndex(index) as? HistoryRow {
					row.weightLabel.setText("\(kilograms!)")
					print(dateString)
					row.dateLabel.setText(dateString)
				}
				index++
			}
			
			
		});
	}
	
	
	// MARK: - Lifecycle
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        super.willActivate()
		
		reloadTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
