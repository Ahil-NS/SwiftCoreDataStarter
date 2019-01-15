//
//  ViewController.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var friendMain  = [String]()
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func addFriendButtonTapped(_ sender: UIBarButtonItem) {
        var friend = FriendData()
       
        //TODO
        while friendMain.contains(friend.name) {
            friend = FriendData()
        }
        friendMain.append(friend.name)
        
        let index = IndexPath(item: friendMain.count - 1, section: 0)
        friendsCollectionView.insertItems(at: [index])
    
    }
    
}

extension MainVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(friendMain.count == 0){
            friendsCollectionView.backgroundView = emptyView
        }
        else{
            friendsCollectionView.backgroundView = nil
        }
        return friendMain.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCellId", for: indexPath) as? FriendCell else{ return UICollectionViewCell()}
        cell.configureCell(name: friendMain[indexPath.row])
        return cell
    }
    
    
}
