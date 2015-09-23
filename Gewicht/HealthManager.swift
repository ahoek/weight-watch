//
//  HealthManager.swift
//  Gewicht
//
//  Created by Arthur Hoek on 19-08-15.
//  Copyright (c) 2015 Arthur Hoek. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
	
	let healthKitStore:HKHealthStore = HKHealthStore()
	let type = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
	
	func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!)
	{
		if !HKHealthStore.isHealthDataAvailable() {
			let error = NSError(domain: "nl.arthurhoek.Gewicht", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
			if (completion != nil ) {
				completion(success:false, error:error)
			}
			return
		}
		
		healthKitStore.requestAuthorizationToShareTypes(
			Set(arrayLiteral: type),
			readTypes: Set(arrayLiteral: type),
			completion: { (success: Bool, err: NSError?) -> () in
				print("okay: \(success) error: \(err)")
			}
		)

	}
	
	func storeWeight(weight: Double) {

		let now = NSDate()
	
		healthKitStore.saveObject(
			HKQuantitySample(
				type: type,
				quantity: HKQuantity(unit: HKUnit(fromString: "kg"), doubleValue: weight),
				startDate: now,
				endDate: now,
				metadata: [HKMetadataKeyWasUserEntered: true]
			),
			withCompletion: { (success: Bool, err: NSError?) -> () in
				print("okay: \(success) error: \(err)")
			}
		)
	}
	
	func readMostRecentWeight(completion: (([HKSample]!, NSError!) -> Void)!) {
		let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
		
		// 1. Build the Predicate
		let past = NSDate.distantPast()
		let now = NSDate()
		let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate:now, options: .None)
		
		// 2. Build the sort descriptor to return the samples in descending order
		let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)

		let limit = 10
		
		// 4. Build samples query
		let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
			{ (sampleQuery, results, error ) -> Void in
				
				if (error != nil) {
					completion(nil, error)
					return;
				}
				
				// Execute the completion closure
				if completion != nil {
					completion(results, nil)
				}
			}
		
		// 5. Execute the Query
		self.healthKitStore.executeQuery(sampleQuery)
	}
}