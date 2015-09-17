//
//  HistoryInterfaceController.swift
//  Gewicht
//
//  Created by Arthur Hoek on 17-09-15.
//  Copyright © 2015 Arthur Hoek. All rights reserved.
//

import WatchKit
import Foundation


class HistoryInterfaceController: WKInterfaceController {
	
	
	// Model
	// TODO: get from healthkit
	
	var history = [90.8, 89.5, 70, 80, 80, 80, 80, 80, 80]

	// MARK: - Outlets
	
	@IBOutlet var historyTable: WKInterfaceTable!
	
	
	
	func reloadTable() {
		historyTable.setNumberOfRows(history.count, withRowType: "HistoryRow")
		
		var index = 0
		for entry in history {
			if let row = historyTable.rowControllerAtIndex(index) as? HistoryRow {
				row.weightLabel.setText("\(entry)")
			}
			index++
		}
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
