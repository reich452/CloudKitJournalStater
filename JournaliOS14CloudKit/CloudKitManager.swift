//
//  CloudKitManager.swift
//  JournaliOS14CloudKit
//
//  Created by Nick Reichard on 8/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // Very Generic functions!!!
    
    // an array of Records. can be one or it can be as many as we want. thats why its an arrya
    func modify(records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        // THis is really cool because you can give it an entire array as many records as you want & it will save thoes records in one network call instad of performing mutlipul puts and fetches. THis is much more efficent
        
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys //The policy to apply when the server contains a newer version of a specific record.
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        // saves data. a policy that saves only thoes fiels of the record that chaged
        // much more effiecent
        
        // This handels records as the complete
        operation.perRecordCompletionBlock = perRecordCompletion // We can handel this reocord or error were ever we call this function
        operation.modifyRecordsCompletionBlock = { (records, _, error) in // We do this to avoid the recordIDs
            completion?(records, error)
        }
        // NSOperation - you have to tell it what to do once it has completed
        publicDB.add(operation)
    }
    
    // MARK: - Save
    
    func saveRecords(records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        // save our records but also handel the afterMath of when the Network call comes back to us
        modify(records: records, perRecordCompletion: perRecordCompletion, completion: completion)
    }
    
    // RIGHT OUT OF DOCUMENTATION
    func save(record: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        publicDB.save(record, completionHandler: completionHandler)
    }
    
    // MARK: - Fetching
    
    func fetchRecordsWith(type: String, completion: @escaping ((_ records: [CKRecord]?, _ error: Error?) -> Void)) {
        
        // 1) Create a predicate that gives you everyting. Value = true. Yes I wan't everying
        let predicate = NSPredicate(value: true) // Instagram: I want every post. That would be bad. and not effecent
        
        // 2) Query Takes it 2 things. What kind of record do you want me to gt
        let query = CKQuery(recordType: type, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}
