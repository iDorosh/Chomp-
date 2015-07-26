//
//  BackTableVC.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/15/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import Foundation
import CoreData

class BackTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    var TableArray = [String]()
    var filteredDataArray = [String]()
   
     var searchActive : Bool = false
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTablevView: UITableView!
    override func viewDidLoad() {
        
        
        for var i = 0; i < allRecipes.count; i++
        {
            var recipe = allRecipes[i]
            
            var recipeName = (recipe.valueForKey("name") as? String)!
            TableArray.append(recipeName)
            
        }
        
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        filteredDataArray = TableArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredDataArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.myTablevView.reloadData()
        
    }

    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchActive) {
            return filteredDataArray.count
        }
        return allRecipes.count;
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("recipeCell") as! UITableViewCell
        let recipe = allRecipes[indexPath.row]
        if(searchActive){
            cell.textLabel?.text = filteredDataArray[indexPath.row]
        } else {
            cell.textLabel?.text =  (recipe.valueForKey("name") as? String)!
        }
        
        //cell.textLabel?.text = dataArray[indexPath.row].name
        //cell.textLabel?.text = TableArray[indexPath.row]
        //cell.textLabel?.textColor = UIColor.lightGrayColor()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.myTablevView.reloadData()
    }
    

    
}
