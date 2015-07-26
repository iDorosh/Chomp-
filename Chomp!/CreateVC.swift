//
//  CreateVC.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/18/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit
import CoreData
var allRecipes = [NSManagedObject]()
var ingredientsArray : [String] = [String]()

class CreateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate{
    var myImage : UIImage = UIImage()
    var source : Bool = true
    var value : Int = 0
    var colors = ["Burgers","Cakes","Pies","Salads", "Sandwiches", "Soups" ]
    
   
    var combined : [String] = [String]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var newName: UITextField!
    
    @IBOutlet weak var newDirections: UITextView!
    
    @IBOutlet weak var newCategory: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBAction func editButton(sender: UIButton)
    {
       myTableView.editing = !myTableView.editing
    }
    
    @IBAction func back(segue: UIStoryboardSegue)
    {
    }
    
    @IBAction func showPicker(sender: UIButton)
    {
        picker.hidden = false
        cancelButton.hidden = false
        doneButton.hidden = false
        
    }
    @IBAction func hidePicker(sender: UIButton)
    {
        picker.hidden = true
        cancelButton.hidden = true
        doneButton.hidden = true
        

    }
    
    
    @IBAction func addToCat(sender: UIButton)
    {
        doneButton.hidden = true
        cancelButton.hidden = true
        newCategory.text = colors[value]
        
        picker.hidden = true
    }
    
    
    
    
    @IBAction func gallery(sender: AnyObject)
    {
        var controller : UIImagePickerController = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        self.presentViewController(controller, animated:true, completion:nil)
    }
    @IBAction func camera(sender: AnyObject)
    {
        var controller : UIImagePickerController = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        controller.sourceType = UIImagePickerControllerSourceType.Camera
        source = false
        
        self.presentViewController(controller, animated:true, completion:nil)
    }
    
    
    @IBAction func done(sender: UIBarButtonItem)
    {
        
        if (newName.text == "" || newCategory.text == "" || newDirections.text == "")
        {
            var alert = UIAlertController(title: "Empty Fields", message: "Please complete all fields before saving", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
        var imageData = UIImageJPEGRepresentation(myImage, 0)
        
        self.saveName(newName.text, img: imageData, category: newCategory.text!, directions: newDirections.text)
        
        navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        var mediaDictionary : NSDictionary = info as NSDictionary
        myImage = mediaDictionary.objectForKey("UIImagePickerControllerEditedImage") as! UIImage
        foodImage.image = myImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveName(name: String, img: NSData, category: String, directions: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Recipes",
            inManagedObjectContext:
            managedContext)
        
        let recipe = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        var combinedStrings = "\n".join(ingredientsArray)
        println(combinedStrings)
        recipe.setValue(name, forKey: "name")
        recipe.setValue(img, forKey: "photo")
        recipe.setValue(category, forKey: "category")
        recipe.setValue(directions, forKey: "directions")
        recipe.setValue(combinedStrings, forKey: "ingredients")
        
        
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        allRecipes.append(recipe)
        
    }
    
    @IBAction func addRecipe(sender: UIBarButtonItem)
    {
    }
    
    override func viewWillAppear(animated: Bool) {
        self.myTableView.reloadData()
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
    }

    
    override func viewDidLoad() {

        self.newName.delegate = self
        self.newDirections.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        value = row
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ingredientsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: ingredientTableCell = tableView.dequeueReusableCellWithIdentifier("ingredientCell") as! ingredientTableCell
        
        
        cell.ingredientLabel.text = ingredientsArray[indexPath.row]

        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            ingredientsArray.removeAtIndex(indexPath.row)
            
            myTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        scrollView.setContentOffset(CGPoint(x: 0,y: 250),animated: true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0),animated: true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            newDirections.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newName.resignFirstResponder()
        
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
