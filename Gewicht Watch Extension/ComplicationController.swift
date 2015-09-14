//
//  ComplicationController.swift
//  Gewicht Watch Extension
//
//  Created by Arthur Hoek on 12-09-15.
//  Copyright © 2015 Arthur Hoek. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
		if complication.family == .CircularSmall {
			let template = CLKComplicationTemplateCircularSmallRingText()
			template.textProvider = CLKSimpleTextProvider(text: "AH")
			template.fillFraction = 10.0
			template.ringStyle = CLKComplicationRingStyle.Closed
			
			let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
			handler(timelineEntry)
		} else {
			handler(nil)
		}
    }
	
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(NSDate(timeIntervalSinceNow: 24 * 60*60));
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
		var template: CLKComplicationTemplate? = nil
		switch complication.family {
		case .ModularSmall:
			template = nil
		case .ModularLarge:
			template = nil
		case .UtilitarianSmall:
			template = nil
		case .UtilitarianLarge:
			template = nil
		case .CircularSmall:
			let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
			modularTemplate.textProvider = CLKSimpleTextProvider(text: "--")
			modularTemplate.fillFraction = 0.7
			modularTemplate.ringStyle = CLKComplicationRingStyle.Closed
			template = modularTemplate
		}
		handler(template)
    }
	
}
