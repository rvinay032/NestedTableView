//
//  CellOnCell.swift
//  NestedTableViewPractice
//
//  Created by appinventiv on 07/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class CellOnCell: UITableViewCell {

    
    
    @IBOutlet weak var nestedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
