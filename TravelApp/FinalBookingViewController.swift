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
    
    @IBOutlet weak var progressBar: UIImageView!
    @IBOutlet weak var step2Lbl: UILabel!
    var packageImagePath: String = ""
    override func viewDidLoad() {
        //packageImageView.image = packageImage
        let device=UIDevice.current.name
        if device == "iPhone 8 Plus" || device == "iPhone XR" || device == "iPhone XS Max" || device == "iPhone 7 Plus" || device == "iPhone 6s Plus" {
        
            progressBar.translatesAutoresizingMaskIntoConstraints=true
            progressBar.frame=CGRect(x: 245, y: 0, width: 96, height: 6)
        }
        super.viewDidLoad()

    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

   

}
