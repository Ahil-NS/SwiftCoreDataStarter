//
//  Friend+CoreDataClass.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//
//

import Foundation
import CoreData


public class Friend: NSManagedObject {
    
    var age: Int {
        if let dob = dob as Date? {
            return Calendar.current.dateComponents([.year], from: dob, to: Date()).year!
        }
        return 0
    }

}
