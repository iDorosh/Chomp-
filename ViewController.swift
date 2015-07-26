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

import CoreData


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    var current : Int = Int()
    var decodedimage = UIImage()
    var imageData : NSData = NSData()
    
    @IBAction func backTo(segue: UIStoryboardSegue)
    {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        
        
        menu.target = self.revealViewController()
        menu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        super.viewDidLoad()
    }

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return allRecipes.count
    }
    
    
    
   func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        current = indexPath.row //Sets current to the index of the selected row.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell //Collection view thats sets the information for the cell from the customviewcell.swift file
    {
        var cell : CustomViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomViewCell
        
        let recipe = allRecipes[indexPath.row]
        var cellText: String =  (recipe.valueForKey("name") as? String)!
        imageData = (recipe.valueForKey("photo") as? NSData)!
        decodedimage = UIImage(data: imageData)!
        cell.refreshCell(cellText, recipeImg: decodedimage)
        
        return cell
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "collectionViewSegue")
        {
            var recipelView : Recipe = segue.destinationViewController as! Recipe
            recipelView.index = current
            recipelView.hidden1 = true
            recipelView.imageData = imageData
            var selectedItem: NSManagedObject = allRecipes[current] as NSManagedObject
            recipelView.existingItem = selectedItem
            
        }
        
    }
   
        override func viewWillAppear(animated: Bool) {
            self.navigationController?.navigationBarHidden = false
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Recipes")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            allRecipes = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        self.collectionView.reloadData()
            if (allRecipes.count == 0)
            {
                collectionView.hidden = true
            }
            else
            {
                collectionView.hidden = false
            }
    }
    
    
    }
    
    

