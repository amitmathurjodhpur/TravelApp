//
//  FinalBookingViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 03/03/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class FinalBookingViewController: UIViewController {

    @IBOutlet weak var packageImageView: UIImageView!
    
    var packageImage:UIImage!
    override func viewDidLoad() {
        packageImageView.image=packageImage
        super.viewDidLoad()

    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

   

}
