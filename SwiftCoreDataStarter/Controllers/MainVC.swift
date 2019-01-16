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
    var filteredFriend = [String]()
    var isFiltered = false
    
    
    
    
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
        
        let countFriends = isFiltered ? filteredFriend.count : friendMain.count
        if(countFriends == 0){
            friendsCollectionView.backgroundView = emptyView
        }
        else{
            friendsCollectionView.backgroundView = nil
        }
        return countFriends
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCellId", for: indexPath) as? FriendCell else{ return UICollectionViewCell()}
        let friendName = isFiltered ? filteredFriend[indexPath.row] : friendMain[indexPath.row]
        cell.configureCell(name: friendName)
        return cell
    }
}


extension MainVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryName = searchBar.text else{return}
        filteredFriend = friendMain.filter { (txt) -> Bool in
            return txt.contains(queryName)
        }
        isFiltered = true
       
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
       
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancellll")
        isFiltered = false
        filteredFriend.removeAll()
        searchBar.text = nil
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
    }
}
