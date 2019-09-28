//
//  TableViewCell.swift
//  TravelApp
//
//  Created by Amit Mathur on 18/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var rPrice: UILabel!
    
    @IBOutlet weak var rStar5Img: UIImageView!
    @IBOutlet weak var rStar4Img: UIImageView!
    @IBOutlet weak var rStar3Img: UIImageView!
    
    @IBOutlet weak var rStar2Img: UIImageView!
    @IBOutlet weak var rStar1Img: UIImageView!
    @IBOutlet weak var recomndesPAckDuration: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var packagePrice: UILabel!
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var star1Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var packageNameLabel: UILabel!
    
    @IBOutlet weak var destinationDetailHeader: UILabel!
    @IBOutlet weak var destinationName: UILabel!
    
    @IBOutlet weak var destinationDays: UILabel!
    @IBOutlet weak var destinationDescriptionLabel: UILabel!
    @IBOutlet weak var detailDestinationImage: UIImageView!
    
    @IBOutlet weak var upcomingTotalAmount: UILabel!
    @IBOutlet weak var upcomingTripDate: UILabel!
    @IBOutlet weak var upcomingPackageName: UILabel!
    @IBOutlet weak var upcomingPackageTripImage: UIImageView!
    @IBOutlet weak var processedTaxLbl: UILabel!
    @IBOutlet weak var processedTotalAmount: UILabel!
    @IBOutlet weak var processedPackageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
