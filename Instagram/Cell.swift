//
//  Cell.swift
//  Instagram
//
//  Created by Mac on 11/06/15.
//  Copyright (c) 2015 CZ. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var imagePosted: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
