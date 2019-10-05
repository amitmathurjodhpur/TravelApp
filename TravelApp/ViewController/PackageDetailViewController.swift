//
//  PackageDetailViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 19/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import ImageSlideshow

class PackageDetailViewController: UIViewController,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var packageImageSlides: ImageSlideshow!
    @IBOutlet weak var scrollView: UIScrollView!
   // @IBOutlet weak var packageImageView: UIImageView!
    var packageImagePath: String = ""
    
    @IBOutlet weak var descriptionHeaderView: UILabel!
    var destinationNames=["HANOI","HA LONG BAY"]
    var destinationImageArray=[#imageLiteral(resourceName: "dimg6"),#imageLiteral(resourceName: "img1")]
    let localSource = [ImageSource(imageString: "dimg1")!, ImageSource(imageString: "dimg2")!, ImageSource(imageString: "dimg3")!, ImageSource(imageString: "dimg4")!]
    var packageArray : [Packages] = []
    var packageItinaryArray : [PackageItinerary] = []
    var packId:Int = 0
    @IBOutlet weak var servicesExcludes: UILabel!
    @IBOutlet weak var services: UILabel!
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star1Img: UIImageView!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var duration1: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var duration: UILabel!
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    //MARK:- View did load
    override func viewDidLoad() {
        self.tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight=900
        packageImageSlides.slideshowInterval = 5.0
        packageImageSlides.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        packageImageSlides.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
       
        
        packageImageSlides.pageIndicator = pageControl
        packageImageSlides.activityIndicator = DefaultActivityIndicator()
        packageImageSlides.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PackageDetailViewController.didTap))
        packageImageSlides.addGestureRecognizer(recognizer)
        super.viewDidLoad()
        loadData()

    }
    @objc func didTap() {
        let fullScreenController = packageImageSlides.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    override func viewDidLayoutSubviews() {
        var topPoint = CGFloat()
        var height = CGFloat()
        
        for subview in scrollView.subviews {
            if subview.frame.origin.y > topPoint {
                topPoint = subview.frame.origin.y
                height = subview.frame.size.height
            }
        }
        let contentHeight=height+topPoint
        scrollView.contentSize=CGSize(width: scrollView.frame.width, height: contentHeight)
       // scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+400)
    }
    func loadData()
    {
     //   let id = "215"
        let id = String(packId)
        let api=API.packageDetail+id
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
      //  let header = "$1$UjDcPu4W$9EidH7/9vMgCWOEc4pNFQ0"
        let headerDict: [String:AnyObject] = ["Auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: api, header: headerDict, success: {
            success in
            ActivityIndicator.shared.show(self.view)

            print(success)
            if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                
                if let packageObj  = response["package"] as? [String:Any], packageObj.count>0 {
                    print(packageObj)
                    
                    let package = Packages.init(packageId: packageObj["package_id"] as? String ?? "", packageName: packageObj["package_name"] as? String ?? "", packageCode: packageObj["package_code"] as? String ?? "", packageDescription: packageObj["package_description"] as? String ?? "", duration: packageObj["duration"] as? String ?? "", country: packageObj["package_country"] as? String ?? "",       state: packageObj["package_state"] as? String ?? "", city: packageObj["package_city"] as? String ?? "", location: packageObj["package_location"] as? String ?? "", rating: packageObj["rating"] as? String ?? "", status: packageObj["status"] as? String ?? "", price: packageObj["price"] as? String ?? "", image: packageObj["image"] as? String ?? "", favourite: packageObj["favourite"] as? String ?? "")
                    print(package)
                    self.packageArray.append(package)
                    print(self.packageArray)
                    self.packageImagePath = self.packageArray[0].image
                    let packageItinerary = response["package_itinerary"]
                    print(packageItinerary!)
                    for packItinarray in (packageItinerary as? [[String : Any]])! {
                        let itinerary = PackageItinerary.init(itiId: packItinarray["iti_id"] as? String ?? "", packageId: packItinarray["package_id"] as? String ?? "", city: packItinarray["package_city"] as? String ?? "", day: packItinarray["day"] as? String ?? "", place: packItinarray["place"] as? String ?? "", itiDesc: packItinarray["itinerary_description"] as? String ?? "", itiImage: packItinarray["itinerary_image"] as? String ?? "", itiLink: packItinarray["itinerary_link"] as? String ?? "")
                        print(itinerary)
                       self.packageItinaryArray.append(itinerary)
                    }
                    
                    
                    
                    let packagePricePolicy = response["package_price_policy"] as? Dictionary<String, AnyObject>
                    print(packagePricePolicy!)
                    let packageCancelPolicy = response["package_cancel_policy"] as? Dictionary<String, AnyObject>
                    print(packageCancelPolicy!)
                    let packageTravellerPhotos = response["package_traveller_photos"]
                    print(packageTravellerPhotos!)
                }
                ActivityIndicator.shared.hide()

            } else {
                let alert = UIAlertController(title: "Error", message: "City Not Found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                self.present(alert, animated: true, completion:nil)
            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
        
        
    }
    //MARK:- IBAction methods
    @IBAction func backButtonTapped(_ sender: Any){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        if appDelegate.isTabBarBtnPress! {
            if let packageVc = self.storyboard?.instantiateViewController(withIdentifier: "PackageViewController") as? PackageViewController {
                self.definesPresentationContext = true
                packageVc.modalPresentationStyle = .overCurrentContext
                self.present(packageVc, animated: false, completion: nil)
                appDelegate.isTabBarBtnPress=false
            }
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    @IBAction func bookNowButtonTapped(_ sender: Any) {
        if let bookingVC = self.storyboard?.instantiateViewController(withIdentifier: "BookingViewController") as? BookingViewController {
            bookingVC.packageImagePath = packageImagePath
            bookingVC.rating = packageArray[0].rating
            bookingVC.duration = packageArray[0].duration
            BookingEntries.shared.packageID = String(self.packId)
            self.present(bookingVC, animated: true, completion: nil)
            
        }
    }
    // MARK:-  UITableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(packageArray.count)
       // return packageArray.count
        return destinationImageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       //filling data
        cell.destinationName.text=destinationNames[indexPath.row]
        cell.detailDestinationImage.image=destinationImageArray[indexPath.row]
        
        
        switch indexPath.row {
        case 0:
            cell.destinationDetailHeader.text="Hanoi arrival and city tour"
            cell.destinationDescriptionLabel.text="Upon arrival at the airport and after clearing the immigrations and customs, meet with your guide and embark on your comfortable car for transferring to the hotel for check-in or drop off your luggage.After that, visit Hanoi. With ochre-coloured colonial buildings, tree-lined boulevards and scenic lakes, Hanoi is full of charm. Start the tour at the historic Ho Chi Minh Mausoleum, an imposing monument lavishly built using marble and granite, and where the preserved body of “Uncle Ho” resides. A short walk from the mausoleum is the lotus shaped One Pillar Pagoda – resting on a single stone pillar emerging from the water. Wind your way afterwards to the Temple of Literature, the first University for the sons of mandarins, for  an overview  about Hanoian culture and appreciation for ancient Vietnamese architecture.  Then, drive back your hotel and overnight in Hanoi."
            cell.destinationDays.text = "Day 1"
          
        case 1:
            cell.destinationDetailHeader.text="A world Heritage"
            cell.destinationDescriptionLabel.text="Breakfast at hotel then depart for a 3.5 hour drive from Hanoi to Halong Bay with a rest stop at souvenir shop. Observe some of the local traditions and architecture before continuing to Halong Bay. Upon arrival at Halong Bay, board the private junk at noon and begin magnificent a 4 hour cruise through the spectacular limestone karsts of Halong Bay. Stop along the way to explore the limestone caves or just laze about on the upper deck and admire the stunning scenery. Awarded in 1994 with the UNESCO World Heritage seal, Halong Bay is one of Vietnam’s most spectacular natural wonders. Nearly 2000 limestone islands make up for a maze of limestone karsts with numerous caves, beaches and hidden lagoons. The tiny limestone islands are dotted with many beaches and grottoes and provide an excellent backdrop for swimming. Drop off at the boat docking station and transfer to you hotel in Ha Long."
            cell.destinationDays.text = "Day 2"

        default:
            cell.destinationDetailHeader.text="A world Heritage"
            cell.destinationDescriptionLabel.text="Breakfast at hotel then depart for a 3.5 hour drive from Hanoi to Halong Bay with a rest stop at souvenir shop. Observe some of the local traditions and architecture before continuing to Halong Bay. Upon arrival at Halong Bay, board the private junk at noon and begin magnificent a 4 hour cruise through the spectacular limestone karsts of Halong Bay. Stop along the way to explore the limestone caves or just laze about on the upper deck and admire the stunning scenery. Awarded in 1994 with the UNESCO World Heritage seal, Halong Bay is one of Vietnam’s most spectacular natural wonders. Nearly 2000 limestone islands make up for a maze of limestone karsts with numerous caves, beaches and hidden lagoons. The tiny limestone islands are dotted with many beaches and grottoes and provide an excellent backdrop for swimming. Drop off at the boat docking station and transfer to you hotel in Ha Long."
        }
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none

        
        return cell
    }
//    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 258.0
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
