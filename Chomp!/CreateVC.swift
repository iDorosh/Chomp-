//
//  CreateVC.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/18/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit

class CreateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var source : Bool = true
    @IBOutlet weak var foodImage: UIImageView!
    
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
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        var mediaDictionary : NSDictionary = info as NSDictionary
        var myImage : UIImage = UIImage()
        if (source == true)
        {
             myImage = mediaDictionary.objectForKey("UIImagePickerControllerOriginalImage") as! UIImage
        }
        else
        {
            myImage = mediaDictionary.objectForKey("UIImagePickerControllerEditedImage") as! UIImage
        }
       
        foodImage.image = myImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
