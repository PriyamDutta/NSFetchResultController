//
//  PersonInfo+CoreDataClass.swift
//  FetchResultsController
//
//  Created by Priyam Dutta on 23/02/17.
//  Copyright © 2017 Priyam Dutta. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(PersonInfo)
public class PersonInfo: NSManagedObject {
    
    
    /// Insertion Data into Database and saving
    ///
    /// - Parameters:
    ///   - name: name of the person
    ///   - place: place belong to
    class func insertPersonDetails(name: String?, place: String?) {
        let enity = NSEntityDescription.insertNewObject(forEntityName: "PersonInfo", into: manageObjectContext) as! PersonInfo
        enity.name = name
        enity.place = place
        do{
            try manageObjectContext.save()
        }catch let error as NSError{
            debugPrint(error.localizedDescription)
        }
    }
    
}
