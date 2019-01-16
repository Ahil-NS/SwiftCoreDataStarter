//
//  FriendData.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

class FriendData{
    var name: String
    var phoneNum: String
    
    private let names = ["Ahil","Arul","Logi","Ragul","Mayoo"]
    private let phoneNumers = ["001","002","003","004","005"]
    
    init(){
        let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
        name = names[randomIndex]
        phoneNum = phoneNumers[randomIndex]
    }
}
