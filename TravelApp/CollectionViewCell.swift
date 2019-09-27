//
//  CollectionViewCell.swift
//  TravelApp
//
//  Created by Amit Mathur on 13/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var packageImageView: UIImageView!
    
   // @IBOutlet weak var featuredCityLbl: UILabel!
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var packageName: UILabel!
    
    @IBOutlet weak var favImg: UIButton!
    @IBOutlet weak var featuredPrice: UILabel!
    
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star1Img: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var packageRate: UILabel!
    
    @IBOutlet weak var destinationImageView: UIImageView!
    
//    override var isSelected: Bool {
//        didSet {
//            if self.isSelected {
//               self.featuredCityLbl.textColor = UIColor.darkGray
//                self.featuredCityLbl.font = self.featuredCityLbl.font.withSize(13.0)
//
//            }
//            else {
//                self.featuredCityLbl.textColor = UIColor.gray
//                self.featuredCityLbl.font = self.featuredCityLbl.font.withSize(11.0)
//
//
//            }
//        }
//    }
    
    
    
}
