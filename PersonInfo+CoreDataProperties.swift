//
//  PersonInfo+CoreDataProperties.swift
//  FetchResultsController
//
//  Created by Priyam Dutta on 23/02/17.
//  Copyright © 2017 Priyam Dutta. All rights reserved.
//

import Foundation
import CoreData


extension PersonInfo {

    @nonobjc public class func fetchRequestInfo() -> NSFetchRequest<PersonInfo> {
        return NSFetchRequest<PersonInfo>(entityName: "PersonInfo");
    }

    @NSManaged public var name: String?
    @NSManaged public var place: String?

}
