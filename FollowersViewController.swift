//
//  FollowersViewController.swift
//  MDF2_Dorosh_Ian_Week2
//
//  Created by Ian Dorosh on 5/11/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//


import UIKit
import Accounts
import Social
var dataArray: [info] = []

class FollowersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var accountStore : ACAccountStore = ACAccountStore();
    var current : Int = Int()
    var followersDataArray : [String]! = ["hello", "world", "Ian"]
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        
        
        var recipe1: info = info()
        recipe1.name = "Pulled Pork Sandwich"
        recipe1.category = "Sandwich"
        recipe1.directions = "Set the oven to 220 degrees farenheight."
        recipe1.photo = "pork.png"

        
        var recipe2: info = info()
        recipe2.name = "Clam Chouder"
        recipe2.category = "Soup"
        recipe2.directions = "Set the stove on high."
        recipe2.photo = "chouder.png"
        
        var recipe3: info = info()
        recipe3.name = "Hawaiian Buger"
        recipe3.category = "Burger"
        recipe3.directions = "Set grill to medium heat."
        recipe3.photo = "burger.png"
        
        dataArray.append(recipe1)
        dataArray.append(recipe2)
        dataArray.append(recipe3)
        
        super.viewDidLoad()
        
        menu.target = self.revealViewController()
        menu.action = Selector("revealToggle:")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArray.count
    }
    
   func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        current = indexPath.row //Sets current to the index of the selected row.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell //Collection view thats sets the information for the cell from the customviewcell.swift file
    {
        var cell : CustomViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomViewCell
        var cellText: String =  dataArray[indexPath.row].name
        var cellPhoto: String = dataArray[indexPath.row].photo
        cell.refreshCell(cellText, recipeImg: cellPhoto)
        
        return cell
    }
    
}
