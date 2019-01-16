//
//  Friend+CoreDataProperties.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}
