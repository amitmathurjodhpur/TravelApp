//
//  FirstViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 12/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import QuartzCore
import SDWebImage

class PackageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var packageCollectionView: UICollectionView!
    @IBOutlet weak var destinationCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var packageImageArray=[#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    var destinationNames=["Ha Long Bay","Fansipan","Catba island","Ha Long Bay","Ha Long Bay","Ha Long Bay","Ha Long Bay"]
    var destinationImageArray=[#imageLiteral(resourceName: "dimg6"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "dimg5"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "dimg3"),#imageLiteral(resourceName: "img6"),#imageLiteral(resourceName: "dimg2")]
    var packageArray : [Packages] = []
    var recomndedPackageArray : [Packages] = []
    var featuredPackageArray : [Packages] = []
    var cityArray : [Cities] = []

    var currentSelectedBtnColor:UIColor!
    var unselectedColor:UIColor!
    var subviewArray:[UIButton]=[]
    var imagePath: String = ""
    let fullStarImage = UIImage(named: "Star gold.png")!
    let emptyStarImage = UIImage(named: "Star.png")!
    var packageId:Int = 0
    var cityId:Int = 0
    var isFirstTimeCreated: Bool = false
    
    @IBOutlet weak var contentView: UIView!
    //MARK:- view did load
    override func viewDidLoad() {
       //  ActivityIndicator.shared.show(self.view)
        super.viewDidLoad()
        scrollView.isScrollEnabled=true
       loadData()
        loadCities()
       
        
    }
    @IBAction func searchTapped(_ sender: Any) {
        if let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            self.definesPresentationContext = true
            searchVC.modalPresentationStyle = .overCurrentContext
            self.present(searchVC, animated: true, completion: nil)

        }
        
    }
    
    @IBAction func destinationNameOpnTapped(_ sender: Any) {
        guard let selectedButton = sender as? UIButton else {
            return
        }
       for subview in subviewArray {
        if subview.tag==selectedButton.tag {
            selectedButton.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            selectedButton.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
        }
        else{
            subview.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            subview.setTitleColor(unselectedColor, for: UIControl.State.normal)
        }
    }
}
    
    override func viewDidLayoutSubviews() {
        var topPoint = CGFloat()
        var height = CGFloat()
        
        for subview in contentView.subviews {
            if subview.frame.origin.y > topPoint {
                topPoint = subview.frame.origin.y
                height = subview.frame.size.height
            }
        }
        let contentHeight=height+topPoint
       // var size1=self.view.frame.height+500
        scrollView.contentSize=CGSize(width: scrollView.frame.width, height: contentHeight)
       
        
      
    }
    func loadCities(){
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.cities, header: headerDict, success: {
            success in
            if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                ActivityIndicator.shared.hide()
                if let cities = response["cities"] {
                    for city in (cities as? [[String : Any]])! {
                        let cityObj = Cities.init(cityId: city["id"] as? String ?? "", cityCountry: city["country"] as? String ?? "", cityName: city["city"] as? String ?? "")
                        self.cityArray.append(cityObj)
                    }
                }
                self.featuredCollectionView.reloadData()
            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
        
    }
    func loadData() {
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        ActivityIndicator.shared.show(self.view)
        
        DataManager.getAPIWithHeader(urlString: API.dashBoard, header: headerDict, success: {
            success in

            if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                print(response)
                if let packagesArr = response["packages"] {
                    for packageObj in (packagesArr as? [[String : Any]])! {
                        let package = Packages.init(packageId: packageObj["package_id"] as? String ?? "", packageName: packageObj["package_name"] as? String ?? "", packageCode: packageObj["package_code"] as? String ?? "", packageDescription: packageObj["package_description"] as? String ?? "", duration: packageObj["duration"] as? String ?? "", country: packageObj["package_country"] as? String ?? "",       state: packageObj["package_state"] as? String ?? "", city: packageObj["package_city"] as? String ?? "", location: packageObj["package_location"] as? String ?? "", rating: packageObj["rating"] as? String ?? "", status: packageObj["status"] as? String ?? "", price: packageObj["price"] as? String ?? "", image: packageObj["image"] as? String ?? "", favourite: packageObj["favourite"] as? String ?? "")
                        self.packageArray.append(package)

                    }
                }
                if let recomndedPackArr = response["recommended_packages"] {
                    for recomnPack in (recomndedPackArr as? [[String : Any]])! {
                        let recomndedpackage = Packages.init(packageId: recomnPack["package_id"] as? String ?? "", packageName: recomnPack["package_name"] as? String ?? "", packageCode: recomnPack["package_code"] as? String ?? "", packageDescription: recomnPack["package_description"] as? String ?? "", duration: recomnPack["duration"] as? String ?? "", country: recomnPack["package_country"] as? String ?? "",       state: recomnPack["package_state"] as? String ?? "", city: recomnPack["package_city"] as? String ?? "", location: recomnPack["package_location"] as? String ?? "", rating: recomnPack["rating"] as? String ?? "", status: recomnPack["status"] as? String ?? "", price: recomnPack["price"] as? String ?? "", image: recomnPack["image"] as? String ?? "", favourite: recomnPack["favourite"] as? String ?? "")
                        self.recomndedPackageArray.append(recomndedpackage)
                    }
                }
                if let featuredPackArr = response["featured_packages"] {
                    for featuredPack in (featuredPackArr as? [[String : Any]])! {
                        let featuredpackage = Packages.init(packageId: featuredPack["package_id"] as? String ?? "", packageName: featuredPack["package_name"] as? String ?? "", packageCode: featuredPack["package_code"] as? String ?? "", packageDescription: featuredPack["package_description"] as? String ?? "", duration: featuredPack["duration"] as? String ?? "", country: featuredPack["package_country"] as? String ?? "", state: featuredPack["package_state"] as? String ?? "", city: featuredPack["package_city"] as? String ?? "", location: featuredPack["package_location"] as? String ?? "", rating: featuredPack["rating"] as? String ?? "", status: featuredPack["status"] as? String ?? "", price: featuredPack["price"] as? String ?? "", image: featuredPack["image"] as? String ?? "", favourite: featuredPack["favourite"] as? String ?? "")
                        self.featuredPackageArray.append(featuredpackage)                    }
                }
                self.packageCollectionView.reloadData()
                self.destinationCollectionView.reloadData()
                self.tableView.reloadData()
                ActivityIndicator.shared.hide()

            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
       
    }
    
    
    @IBAction func favriouteTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        ActivityIndicator.shared.show(self.view)
        let packId = packageArray[button.tag].packageId
        let dic = ["package_id":packId]
        if (button.image(for: .normal)?.isEqual(#imageLiteral(resourceName: "fav")))! {
            DataManager.postAPIWithHeaderAndParameters(urlString: API.unfavrt_packages, jsonString: dic as [String : AnyObject], header: headerDict, success:{
                success in
                if let response = success["data"] as? Dictionary<String, AnyObject> , response.count > 0 {
                    print(response)
                    ActivityIndicator.shared.hide()

                    if let msg = response["msg"] as? String {
                        self.showAlert("", msg)
                    }
                   // self.packageCollectionView.reloadData()
                    button.setImage(#imageLiteral(resourceName: "fav1"), for: .normal)
                }
            }, failure: {
                failure in
                ActivityIndicator.shared.hide()
                print(failure)
            })
        }
        else {
            DataManager.postAPIWithHeaderAndParameters(urlString: API.favrt_package, jsonString: dic as [String : AnyObject], header: headerDict, success:{
                success in
                if let response = success["data"] as? Dictionary<String, AnyObject> , response.count > 0 {
                    print(response)
                    ActivityIndicator.shared.hide()

                    if let msg = response["msg"] as? String {
                        self.showAlert("", msg)
                    }
                    button.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                   // self.packageCollectionView.reloadData()
                }
            }, failure: {
                failure in
                ActivityIndicator.shared.hide()
                print(failure)
            })
        }
        
    }
    
    // MARK:- UITableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // DYNAMIC APPROACH
        return recomndedPackageArray.count
        // STATIC APPROACH
       // return destinationImageArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        //DYNAMIC APPROACH
        imagePath=recomndedPackageArray[indexPath.row].image
        cell.packageImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"))

        cell.packageNameLabel.text=recomndedPackageArray[indexPath.row].packageName
        let rating = recomndedPackageArray[indexPath.row].rating
        for (index, imageView) in [cell.rStar1Img, cell.rStar2Img, cell.rStar3Img, cell.rStar4Img, cell.rStar5Img].enumerated() {
            imageView?.image = getStarImage(starNumber: Int(index + 1), forRating: Int(rating)!)
        }
        let duration = Int(recomndedPackageArray[indexPath.row].duration)
        if duration == 1 {
            cell.recomndesPAckDuration.text = "\(duration!)DAYS"
        } else {
            cell.recomndesPAckDuration.text = "\(duration!)DAYS/\(duration!-1)NIGHTS"
        }
        cell.rPrice.text = "$\(recomndedPackageArray[indexPath.row].price)"

        // STATIC APPROACH
//        cell.packageImage.image=packageImageArray[indexPath.row]
//
//        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
//        /// change size as you need.
//        separatorLineView.backgroundColor = self.view.backgroundColor
//        // you can also put image here
//        cell.contentView.addSubview(separatorLineView)
//        cell.selectionStyle=UITableViewCell.SelectionStyle.none

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
// MARK: UICollectionView Delegate & Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return packageArray.count
         //   return packageImageArray.count   // STATIC
        } else if collectionView.tag == 11 {
          //  return destinationNames.count  // STATIC
           return cityArray.count
        }
        else {
            return featuredPackageArray.count  // STATIC
      //          return destinationImageArray.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollectionView {
             let cell:FeaturedCollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeaturedCollectionViewCell
           cell.featuredCityLbl.text = cityArray[indexPath.row].name   // DYNAMIC
          //  cell.featuredCityLbl.text = destinationNames[indexPath.row] //STATIC
            if indexPath.row == 0 && !isFirstTimeCreated {
                cell.featuredCityLbl.textColor = UIColor.darkGray
                cell.featuredCityLbl.font = cell.featuredCityLbl.font.withSize(13.0)
                isFirstTimeCreated = true
            } else {
                cell.featuredCityLbl.textColor = UIColor.gray
                cell.featuredCityLbl.font = cell.featuredCityLbl.font.withSize(11.0)
            }
            return cell
        } else {
            let cell:CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            if collectionView == packageCollectionView {
                
                //DYNAMIC APPROACH
                
                imagePath=packageArray[indexPath.row].image
                cell.packageImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"))
              //  let packLength = packageArray[indexPath.row].packageName.count
//                if packLength > 15 {
//                   let name = packageArray[indexPath.row].packageName as? String
//
//                }
                cell.packageName.text = packageArray[indexPath.row].packageName
                let rating = packageArray[indexPath.row].rating
                for (index, imageView) in [cell.star1Img, cell.star2Img, cell.star3Img, cell.star4Img, cell.star5Img].enumerated() {
                    imageView?.image = getStarImage(starNumber: Int(index + 1), forRating: Int(rating)!)
                }
                let duration = Int(packageArray[indexPath.row].duration)
                if duration == 1 {
                    cell.duration.text = "\(duration!)DAY"
                } else {
                    cell.duration.text = "\(duration!)DAYS/\(duration!-1)NIGHTS"
                }
                cell.price.text = "$\(packageArray[indexPath.row].price)"
                let fav = packageArray[indexPath.row].favourite
                print(fav)
                if fav == "1" {
                    cell.favImg.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                    print("Red")
                } else {
                    cell.favImg.setImage(#imageLiteral(resourceName: "fav1"), for: .normal)
                }
                cell.favImg.tag = indexPath.row
                
                
                // STATIC APPROACH
                
//                cell.packageImageView.image = packageImageArray[indexPath.row]
//                cell.packageName.text = destinationNames[indexPath.row]
            }
            else {
                // DYNAMIC APPROACH
                
                imagePath=featuredPackageArray[indexPath.row].image
                cell.destinationImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"))
                cell.featuredPrice.text = "$\(featuredPackageArray[indexPath.row].price)"
                
                // STATIC APPROACH
              //  cell.destinationImageView.image=destinationImageArray[indexPath.row]

                //cell.destinationNameLabel.text=destinationNames[indexPath.row]
            }
            return cell

        }
        
        
        
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell

        if collectionView.tag == 1 {
            if let packageDetail = self.storyboard?.instantiateViewController(withIdentifier: "PackageDetailViewController") as? PackageDetailViewController {
             //   packageDetail.packageImage=packageImageArray[indexPath.row]
                packageId = Int(packageArray[indexPath.row].packageId)!
                packageDetail.packId = packageId
                self.definesPresentationContext = true
                packageDetail.modalPresentationStyle = .overCurrentContext
                self.present(packageDetail, animated: false, completion: nil)
            }
        } else if collectionView.tag == 11 {
            cityId = Int(cityArray[indexPath.row].id)!   //dynamic
            
            print(cityId)
//            if selectedCell.featuredCityLbl.textColor == UIColor.gray {
//                selectedCell.featuredCityLbl.textColor = UIColor.darkGray
//                selectedCell.featuredCityLbl.font = selectedCell.featuredCityLbl.font.withSize(13.0)
//
//            } else {
//                selectedCell.featuredCityLbl.textColor = UIColor.gray
//                selectedCell.featuredCityLbl.font = selectedCell.featuredCityLbl.font.withSize(11.0)
//            }

        }
    }
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//       // let deselectedCell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//         let deselectedCell:CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//
//        if collectionView.tag == 11 {
//            deselectedCell.featuredCityLbl.textColor = UIColor.gray
//            deselectedCell.featuredCityLbl.font = deselectedCell.featuredCityLbl.font.withSize(11.0)
//        }
//
//    }
    func getStarImage(starNumber: Int, forRating rating: Int) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else {
            return emptyStarImage
        }
    }
    // MARK: showAlert
    func showAlert(_ title:String?,_ message:String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

