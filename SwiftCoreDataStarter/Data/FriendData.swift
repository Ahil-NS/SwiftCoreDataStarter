//
//  FriendData.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class FriendData{
    var name: String
    var phoneNum: String
    var dob = Date()
    var eyeColor: UIColor?
    
    private let names = ["Ahil","Arul","Logi","Ragul","Mayoo"]
    private let phoneNumers = ["001","002","003","004","005"]
    private let eyeColors = [UIColor.black, UIColor.blue, UIColor.brown, UIColor.green, UIColor.gray]
    
    init(){
        let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
        name = names[randomIndex]
        phoneNum = phoneNumers[randomIndex]
        dob = Date().random(unit: Calendar.Component.year, from: -10, upto: -90)!
        eyeColor = eyeColors[randomIndex]
        
    }
}
