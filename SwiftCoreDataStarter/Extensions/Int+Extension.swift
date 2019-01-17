//
//  Int+Extension.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/17/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

extension Int {
    func random() -> Int {
        let isNegative = self < 0
        let random = Int(arc4random_uniform(UInt32(abs(self)))) * (isNegative ? -1 : 1)
        return random
    }
}
