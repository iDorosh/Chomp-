//
//  CustomViewCell.swift
//  MDF2_Dorosh_Ian_Week2
//
//  Created by Ian Dorosh on 5/11/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit

class CustomViewCell: UICollectionViewCell
{
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
  
    
    func refreshCell(cellText: String, recipeImg: String)
    {
        myLabel!.text = cellText
        picture!.image = UIImage(named: recipeImg)
        
        
    }
    
}
