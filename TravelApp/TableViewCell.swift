//
//  TableViewCell.swift
//  TravelApp
//
//  Created by Amit Mathur on 18/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var packageImage: UIImageView!
    
    @IBOutlet weak var packageNameLabel: UILabel!
    
    @IBOutlet weak var destinationName: UILabel!
    
    @IBOutlet weak var destinationDescriptionLabel: UILabel!
    @IBOutlet weak var detailDestinationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
