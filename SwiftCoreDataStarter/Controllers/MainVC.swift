//
//  ViewController.swift
//  SwiftCoreDataStarter
//
//  Created by MacBook on 1/15/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    private var friendMain  = [Friend]()
    
    
    //    private var filteredFriend = [Friend]()
    //    private var isFiltered = false
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var selectedIndexPath: IndexPath!
    private var imagePicker = UIImagePickerController()
    
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    
    @IBAction func addFriendButtonTapped(_ sender: UIBarButtonItem) {
        
        let data = FriendData()
        let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.name = data.name
        friend.phone = data.phoneNum
        friend.dob = data.dob as NSDate
        friend.eyeColor = data.eyeColor
        
        appDelegate.saveContext()
        
        //sort and add data to collectionview
        refresh()
        friendsCollectionView.reloadData()
        
        //friendMain.append(friend)
//        let index = IndexPath(item: friendMain.count - 1, section: 0)
//        friendsCollectionView.insertItems(at: [index])
        
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
    
    private func refresh(){
        let request = Friend.fetchRequest() as NSFetchRequest<Friend>
        
       // let sort = NSSortDescriptor(keyPath: \Friend.name, ascending: true)
        
        //case insensitive sort
        let sort = NSSortDescriptor(key: #keyPath(Friend.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        do{
            friendMain = try context.fetch(request)
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}

extension MainVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        let countFriends = isFiltered ? filteredFriend.count : friendMain.count
        let countFriends = friendMain.count
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
        //        let friend = isFiltered ? filteredFriend[indexPath.row] : friendMain[indexPath.row]
        let friend = friendMain[indexPath.row]
        cell.configureCell(name: friend.name!, phone: friend.phone, age: friend.age, color: friend.eyeColor as? UIColor, image: friend.photo)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        present(imagePicker, animated: true, completion: nil)
    }
}


extension MainVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryName = searchBar.text else{return}
        
        //Filter directly from Coredata
        let request = Friend.fetchRequest() as NSFetchRequest<Friend>
        
       
        
        
        
        //cd used for avoid case sensitive search
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", queryName)
        
        let sort = NSSortDescriptor(keyPath: \Friend.name, ascending: true)
        request.sortDescriptors = [sort]
        
        do{
            friendMain = try context.fetch(request)
        }
        catch let error as NSError{
            print("Could not fetch , \(error) \(error.userInfo)")
        }
        //Filter from [Friend]()
        //        filteredFriend = friendMain.filter({ (friend) -> Bool in
        //            return friend.name!.contains(queryName)
        //        })
        
        //Filter from array of string
        //        filteredFriend = friendMain.filter { (txt) -> Bool in
        //            return txt.contains(queryName)
        //        }
        
        //isFiltered = true
        
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh()
        //        isFiltered = false
        //        filteredFriend.removeAll()
        searchBar.text = nil
        searchBar.resignFirstResponder()
        friendsCollectionView.reloadData()
    }
}

extension MainVC: UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //            let friends = isFiltered ? filteredFriend[selectedIndexPath.row] : friendMain[selectedIndexPath.row]
            let friends = friendMain[selectedIndexPath.row]
            friends.photo = pickedImage.pngData() as NSData?
            appDelegate.saveContext()
            
            friendsCollectionView.reloadItems(at: [selectedIndexPath])
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
}
