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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    var current : Int = Int()
    
    @IBAction func backTo(segue: UIStoryboardSegue)
    {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        menu.target = self.revealViewController()
        menu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        var recipe1: info = info()
        recipe1.name = "Pulled Pork"
        recipe1.category = "Sandwiches"
        recipe1.directions = "Place the onions and garlic in an even layer in the slow cooker and pour in the stock or broth. Combine the sugar, chili powder, measured salt, cumin, and cinnamon in a small bowl. Pat the pork dry with paper towels. Rub the spice mixture all over the pork and place the meat on top of the onions and garlic. Cover and cook until the pork is fork tender, about 6 to 8 hours on high or 8 to 10 hours on low."
        recipe1.ingredients = "1 tbsp ground cumin\n1 tbsp garlic powder\n1 tbsp onion powder\n1 tbsp chili powder\n1 tbsp cayenne pepper"
        
        recipe1.photo = "pork.png"

        
        var recipe2: info = info()
        recipe2.name = "Clam Chouder"
        recipe2.category = "Soups"
        recipe2.directions = "In a large dutch  oven, cook bacon until crisp and fat is rendered. Pour off all but 2 tablespoons of the bacon fat. Add the butter, onions, celery, garlic, and bay leaf and cook about 5 minutes until vegetables are tender."
        recipe2.ingredients = "1 can of clams\n1/2 cup of bacon\n1 cup of diced potatoes\n1/2 tsp of salt\n1/2 tsp pepper"
        recipe2.photo = "chouder.png"
        
        var recipe3: info = info()
        recipe3.name = "Hawaiian Burger"
        recipe3.category = "Burgers"
        recipe3.directions = "For the burgers: Gently combine the ground beef with grated carrots, scallions, ginger, soy sauce and sriracha sauce. Form into 8 equal sized patties, try not to overwork the meat so it doesn't get tough."
        recipe3.ingredients = "1 tbsp ground cumin\n1 tbsp garlic powder\n1 tbsp onion powder\n1 tbsp chili powder\n1 tbsp cayenne pepper"
        recipe3.photo = "burger.png"
        
        dataArray.append(recipe1)
        dataArray.append(recipe2)
        dataArray.append(recipe3)
        
        super.viewDidLoad()
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
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "collectionViewSegue")
        {
            var recipelView : Recipe = segue.destinationViewController as! Recipe
            recipelView.index = current
            recipelView.hidden1 = true
            
        }
        
    }
    
    
}
