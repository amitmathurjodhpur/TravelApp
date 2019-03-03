//
//  PackageDetailViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 19/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class PackageDetailViewController: UIViewController,UITabBarDelegate,UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var packageImageView: UIImageView!
    var packageImage:UIImage!
    
    @IBOutlet weak var descriptionHeaderView: UILabel!
    var destinationNames=["Ha Long Bay","Fansipan","Catba island","Ha Long Bay","Ha Long Bay","Ha Long Bay","Ha Long Bay"]
    var destinationImageArray=[#imageLiteral(resourceName: "dimg6"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "dimg5"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "dimg3"),#imageLiteral(resourceName: "img6"),#imageLiteral(resourceName: "dimg2")]
    
    override func viewDidLoad() {
        packageImageView.image=packageImage
       // textView.backgroundColor=UIColor.purple
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+400)
    }
    
    @IBAction func backButtonTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookNowButtonTapped(_ sender: Any) {
        if let BookingVC = self.storyboard?.instantiateViewController(withIdentifier: "BookingViewController") as? BookingViewController {
            BookingVC.packageImage=packageImage
//            self.definesPresentationContext = true
//            BookingVC.modalPresentationStyle = .overCurrentContext
            self.present(BookingVC, animated: true, completion: nil)
            
        }
    }
    // Mark UITableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       //filling data
        cell.destinationName.text=destinationNames[indexPath.row]
        cell.detailDestinationImage.image=destinationImageArray[indexPath.row]
        cell.destinationDescriptionLabel.text="itam et,consectetur. Nul larhoncusultricespurus, volutpat. Lorem ipsum dolorsitamet, consecteturelit."
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
