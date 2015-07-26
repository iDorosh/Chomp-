//
//  Recipe.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/17/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit
import UIKit
import MessageUI
import CoreData


class Recipe: UIViewController, MFMailComposeViewControllerDelegate{
    
    var index: Int? = 0
    var hidden1 : Bool = false
    var existingItem : NSManagedObject!
    var imageData: NSData = NSData()
    

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeCat: UILabel!
    @IBOutlet weak var recipePic: UIImageView!
    
    
    
    @IBOutlet weak var directions: UITextView!
    
    @IBOutlet weak var ingredients: UITextView!
    
    @IBAction func homeButton(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   var itemName = "test"
    
    @IBAction func removeRecipe(sender: AnyObject)
    {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        context.deleteObject(allRecipes[index!] as NSManagedObject)
        allRecipes.removeAtIndex(index!)
        context.save(nil)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    

    @IBAction func sendEmail(sender: UIBarButtonItem)
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func back(sender: UIBarButtonItem)
    {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBarHidden = true
        let recipe = allRecipes[index!]
        recipeTitle.text = (recipe.valueForKey("name") as? String)!
        recipeCat.text = (recipe.valueForKey("category") as? String)!
        
        
        imageData = (recipe.valueForKey("photo") as? NSData)!
        var decodedimage = UIImage(data: imageData)!
        
        recipePic.image = decodedimage as UIImage
        ingredients.text = (recipe.valueForKey("ingredients") as? String)!
        directions.text = (recipe.valueForKey("directions") as? String)!
        
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([])
        mailComposerVC.setSubject(recipeTitle.text!+" Recipe")
        mailComposerVC.setMessageBody(ingredients.text+"\n\n"+directions.text, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
        
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "editSegue")
        {
            var editView : EditViewViewController  = segue.destinationViewController as! EditViewViewController
            editView.currentName = recipeTitle.text!
            editView.currentCat = recipeCat.text!
            editView.currentImage = imageData
            editView.currentIngredients = ingredients.text!
            editView.currentDirections = directions.text!
            editView.existingItem = existingItem
            
        }
    }

}
