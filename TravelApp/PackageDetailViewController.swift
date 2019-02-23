//
//  PackageDetailViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 19/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class PackageDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var packageImageView: UIImageView!
    var packageImage:UIImage!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        packageImageView.image=packageImage
       // textView.backgroundColor=UIColor.purple
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+500)
    }
    
    @IBAction func backButtonTapped(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
