//
//  Recipe.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/17/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit

class Recipe: UIViewController {
    
    var index: Int? = 0
    var hidden1 : Bool = false

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeCat: UILabel!
    @IBOutlet weak var recipePic: UIImageView!
    
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var directions: UILabel!
    
    @IBOutlet weak var showBar: UINavigationBar!
    @IBAction func homeButton(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
        recipeTitle.text = dataArray[index!].name
        recipeCat.text = dataArray[index!].category
        recipePic.image = UIImage(named: dataArray[index!].photo)
        ingredients.text = dataArray[index!].ingredients
        directions.text = dataArray[index!].directions
        showBar.hidden = hidden1
        
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
