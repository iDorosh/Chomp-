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
    
    
    var test : Bool = true
    var currentCategories = [Int]()
    var tableArray2 = [String]()
    var filteredCat = [String]()
    var result = Int()
    
    
    var current : Int = Int()
    var decodedimage = UIImage()
    var imageData : NSData = NSData()
    var filteredCandies = [String]()
    var tableArray = [String]()
    
    @IBAction func backTo(segue: UIStoryboardSegue)
    {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad()
    {
        //Creating the menu, search and add icons in the navigation view on the main screen and also setting them to the right colors.
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addTapped:")
        rightAddBarButtonItem.tintColor = UIColor(red: 0.26, green: 0.59, blue: 0.7, alpha: 1.0)
        
        var rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchTapped:")
        rightSearchBarButtonItem.tintColor = UIColor(red: 0.26, green: 0.59, blue: 0.7, alpha: 1.0)
        
        var menu:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self.revealViewController(), action: Selector("revealToggle:"))
        menu.tintColor = UIColor(red: 0.26, green: 0.59, blue: 0.7, alpha: 1.0)
        
        //setting the buttons to the navigation view
        self.navigationItem.setLeftBarButtonItems([menu], animated: true)
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightSearchBarButtonItem], animated: true)
        
        //Adding gesture recognizer to the main screen
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        super.viewDidLoad()
    }
    
    //Search Button to perform search segue
    func searchTapped(sender:UIButton)
    {
        performSegueWithIdentifier("searchSegue", sender: UIBarButtonItem())
    }
    
    //Add Button to perform add Segue
    func addTapped (sender:UIButton)
    {
        performSegueWithIdentifier("createSegue", sender: UIBarButtonItem())
    }

    
    //Sets numbers of row based on if the user sellected a catagory or not.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (test == true)
        {
            return allRecipes.count
        }
        else
        {
            return currentCategories.count
        }
    }
    
    
    //Set current based on if the user sellected a category or not
   func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        if (test == true)
        {
            current = indexPath.row
        }
        else
        {
            current = currentCategories[indexPath.row]
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell : CustomViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomViewCell
        
        //Sending the correct information to recipe view depending if the user selected a specific category
        if (test == true){
            let recipe = allRecipes[indexPath.row]
            var cellText: String =  (recipe.valueForKey("name") as? String)!
            imageData = (recipe.valueForKey("photo") as? NSData)!
            decodedimage = UIImage(data: imageData)!
            cell.refreshCell(cellText, recipeImg: decodedimage)
        }
        if (test == false)
        {
            let recipe = allRecipes[currentCategories[indexPath.row]]
            var cellText: String =  (recipe.valueForKey("name") as? String)!
            imageData = (recipe.valueForKey("photo") as? NSData)!
            decodedimage = UIImage(data: imageData)!
            cell.refreshCell(cellText, recipeImg: decodedimage)
        }
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //prepare for recipe segue
        if (segue.identifier == "collectionViewSegue")
        {
            var recipelView : Recipe = segue.destinationViewController as! Recipe
            recipelView.index = current
            recipelView.imageData = imageData
            var selectedItem: NSManagedObject = allRecipes[current] as NSManagedObject
            recipelView.existingItem = selectedItem
            
        }
       
        
    }
   
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
        
        //Fetching recipes from core data and setting allRecipes to the results
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Recipes")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults
        {
            allRecipes = results
        } else
        {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        self.collectionView.reloadData()
        
        //Shows no recipes label if allrecipes == 0
        if (allRecipes.count == 0)
        {
            collectionView.hidden = true
        }
        else
        {
            collectionView.hidden = false
        }
        
        //sets tablearray2 to all the recipe names so it can be used to determine which category was being selected
        for var i = 0; i < allRecipes.count; i++
        {
            var recipe = allRecipes[i]
                
            var recipeName = (recipe.valueForKey("name") as? String)!
            tableArray2.append(recipeName)
        }
        
        //Sets tableArray to all the recipe names
        for var i = 0; i < allRecipes.count; i++
        {
            var recipe = allRecipes[i]
            
            var recipeName = (recipe.valueForKey("name") as? String)!
            tableArray.append(recipeName)
        }
        
        //filters all the 
        for var i = 0; i < currentCategories.count; i++
        {
            filteredCat.append(tableArray[currentCategories[i]])
        }

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 0.26, green: 0.59, blue: 0.7, alpha: 1.0)]
    }
}
    
    

