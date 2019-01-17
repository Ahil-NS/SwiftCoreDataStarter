//
//  FriendCell.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    func configureCell(name: String,phone: String?,age : Int , color : UIColor?, image : NSData?){
        friendImageView.image = UIImage(named: "addImg")
        nameLabel.text = name
        phoneLabel.text = phone
        ageLabel.text = "age : \(age)"
        colorView.backgroundColor = color
        if let data = image as Data?{
            friendImageView.image = UIImage(data: data)
        }
        else{
            friendImageView.image = UIImage(named: "addImg")
        }
    }
    
}
