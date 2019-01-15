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
    
    func configureCell(name: String){
        friendImageView.image = UIImage(named: "addImg")
        nameLabel.text = name
    }
    
}
