//
//  CustomTableCell.swift
//  MDF_Week1_Dorosh_Ian
//
//  Created by Ian Dorosh on 2/5/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {

    //iboutlets that creates the custom labels in each row
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
