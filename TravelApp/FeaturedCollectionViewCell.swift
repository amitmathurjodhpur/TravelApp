//
//  FeaturedCollectionViewCell.swift
//  TravelApp
//
//  Created by Amit Mathur on 13/05/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredCityLbl: UILabel!
    override var isSelected: Bool {
                didSet {
                    if self.isSelected {
                        if self.featuredCityLbl.textColor == UIColor.gray {
                            self.featuredCityLbl.textColor = UIColor.darkGray
                            self.featuredCityLbl.font = self.featuredCityLbl.font.withSize(13.0)
                        }
                    }
                    else {
                        if self.featuredCityLbl.textColor == UIColor.darkGray {
                            self.featuredCityLbl.textColor = UIColor.gray
                            self.featuredCityLbl.font = self.featuredCityLbl.font.withSize(11.0)
                        }
                      
                    }
                }
            }
}
