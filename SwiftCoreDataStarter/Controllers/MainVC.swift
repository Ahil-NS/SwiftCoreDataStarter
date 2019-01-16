//
//  ViewController.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    private var friendMain  = [Friend]()
    private var filteredFriend = [Friend]()
    private var isFiltered = false
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            friendMain = try context.fetch(Friend.fetchRequest())
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    

    @IBAction func addFriendButtonTapped(_ sender: UIBarButtonItem) {
        
        let data = FriendData()
        let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.name = data.name
        friend.phone = data.phoneNum
        
        appDelegate.saveContext()
        friendMain.append(friend)
        let index = IndexPath(item: friendMain.count - 1, section: 0)
        friendsCollectionView.insertItems(at: [index])
        
        //with out core data
//        var friend = FriendData()
//        //TODO
//        while friendMain.contains(friend.name) {
//            friend = FriendData()
//        }
//        friendMain.append(friend.name)
//        let index = IndexPath(item: friendMain.count - 1, section: 0)
//        friendsCollectionView.insertItems(at: [index])
    
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
        let friend = isFiltered ? filteredFriend[indexPath.row] : friendMain[indexPath.row]
        cell.configureCell(name: friend.name!, phone: friend.phone)
        return cell
    }
}


extension MainVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryName = searchBar.text else{return}
        
        filteredFriend = friendMain.filter({ (friend) -> Bool in
            return friend.name!.contains(queryName)
        })
        
//        filteredFriend = friendMain.filter { (txt) -> Bool in
//            return txt.contains(queryName)
//        }
        isFiltered = true
       
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
       
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = false
        filteredFriend.removeAll()
        searchBar.text = nil
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
    }
}
