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
	let type = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
	
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
			NSSet(objects: type) as Set<NSObject>,
			readTypes: NSSet(objects: type) as Set<NSObject>,
			completion: { (success: Bool, err: NSError!) -> () in
				println("okay: \(success) error: \(err)")
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
			withCompletion: nil
		)
	}
}