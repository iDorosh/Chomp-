//
//  EditViewViewController.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/25/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit
import CoreData

class EditViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var existingItem : NSManagedObject!
    var categories = ["Burgers","Cakes","Pies","Salads", "Sandwiches", "Soups" ]
    var value : Int = 0
    var source : Bool = true
    var myImage : UIImage = UIImage()
    var current : Int = Int()
    
    var currentName: String = String()
    var currentCat : String = String()
    var currentIngredients : String = String()
    var currentDirections : String = String()
    var currentImage : NSData = NSData()
    var decodedimage: UIImage = UIImage()
    
    
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editCategoryLabel: UILabel!
    
    @IBOutlet weak var editIngredients: UITextView!
    @IBOutlet weak var editDirections: UITextView!
    
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var done: UIButton!
    
    @IBOutlet weak var cancel: UIButton!
   
    @IBAction func camera(sender: UIButton)
    {
        var controller : UIImagePickerController = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        controller.sourceType = UIImagePickerControllerSourceType.Camera
        source = false
        
        self.presentViewController(controller, animated:true, completion:nil)
    }
    
    @IBAction func gallery(sender: UIButton)
    {
        var controller : UIImagePickerController = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        self.presentViewController(controller, animated:true, completion:nil)
        
    }
    
    @IBAction func done(sender: UIButton)
    {
        done.hidden = true
        cancel.hidden = true
        editCategoryLabel.text = categories[value]
        
        picker.hidden = true
    }
    
    @IBAction func cancel(sender: UIButton)
    {
        picker.hidden = true
        cancel.hidden = true
        done.hidden = true
    }
    
    
    @IBAction func showPicker(sender: UIButton)
    {
        picker.hidden = false
        cancel.hidden = false
        done.hidden = false
    }
    @IBAction func saveEdit(sender: UIBarButtonItem)
    {
        saveEdit(editName.text, ingredients: editIngredients.text, directions: editDirections.text, category: editCategoryLabel.text!, photo: currentImage)
        println(editName.text)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        println(currentName)
        self.editName.text = currentName
        self.editCategoryLabel.text = currentCat
        decodedimage = UIImage(data: currentImage)!
        self.editImage.image = decodedimage as UIImage
        self.editIngredients.text = currentIngredients
        self.editDirections.text = currentDirections
    }

    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func saveEdit(name: String, ingredients: String, directions: String, category: String, photo: NSData)
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Recipes", inManagedObjectContext: context)
        existingItem.setValue(name, forKey: "name")
        existingItem.setValue(ingredients, forKey: "ingredients")
        existingItem.setValue(directions, forKey: "directions")
        existingItem.setValue(category, forKey: "category")
        existingItem.setValue(photo, forKey: "photo")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        value = row
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        var mediaDictionary : NSDictionary = info as NSDictionary
        myImage = mediaDictionary.objectForKey("UIImagePickerControllerEditedImage") as! UIImage
        current = 1
        currentImage = UIImageJPEGRepresentation(myImage, 0)
        println(myImage)
        picker.dismissViewControllerAnimated(true, completion: nil)
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
