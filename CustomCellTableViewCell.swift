//
//  CustomCellTableViewCell.swift
//  sort search segment
//
//  Created by dietskan on 11/17/16.
//  Copyright © 2016 random. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblprofile: UIImageView!
    @IBOutlet weak var lblsecondrow: UILabel!
    
    
    @IBOutlet weak var lblthirdrow: UILabel!
    
    
    
    @IBOutlet weak var lblfourthrow: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
