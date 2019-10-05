//
//  SearchViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 21/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchResultTabel: UITableView!
    @IBOutlet weak var cityNameTblView: UITableView!

    @IBOutlet weak var priceLbl: UILabel!
    var packageImageArray=[#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    var packageArray : [Packages] = []
    var cityArray : [Cities] = []
    var originalCityNamesArray : [String] = Array()
    var cityNamesArray : [String] = Array()
    var cityID: String = ""
    var imagePath: String = ""
    let datePicker = UIDatePicker()
    let fullStarImage = UIImage(named: "Star gold.png")!
    let emptyStarImage = UIImage(named: "Star.png")!
    var type = 1
    var tapGesture = UITapGestureRecognizer()
    
    //MARK: ViewdidLoad
    override func viewDidLoad() {
        loadCities()
        cityNameTblView.isHidden = true
        searchLabel.isHidden=true
        searchResultTabel.isHidden=true
        startDateTF.delegate = self
        endDateTF.delegate = self
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        locationTextField.inputAccessoryView=toolBar
        searchResultTabel.tableFooterView = UIView()
        cityNameTblView.tableFooterView = UIView()
        locationTextField.addTarget(self, action: #selector(searchRecords(_ :) ), for: .touchDown)

        locationTextField.addTarget(self, action: #selector(searchRecords(_ :) ), for: .editingChanged)
        
        //Tap Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.tapGestureCalled(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
       
        
        
        super.viewDidLoad()
        
    }
    @objc func searchRecords(_ textField:UITextField) {
        print(locationTextField.text!)
        if (locationTextField.text!.isEmpty) {
            for city in originalCityNamesArray {
                cityNamesArray.append(city)
            }
            
        } else {
            self.cityNamesArray.removeAll()
            if let cityToSearch = locationTextField.text {
                for city in originalCityNamesArray {
                    let range = city.lowercased().range(of: cityToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.cityNamesArray.append(city)
                    }
                }
            }
        }
        cityNameTblView.reloadData()   // DYNAMIC
        cityNameTblView.isHidden=false //DYNAMIC
    }
    func loadData() {
        if let locationTxt=locationTextField.text, locationTxt.isEmpty || locationTxt == "" {
            DataManager.showAlert("", "Location is mandatory")
            return
        } else if let startDateTxt = startDateTF.text, startDateTxt.isEmpty || startDateTxt == "" {
            DataManager.showAlert("", "Start Date is mandatory")
            return
        } else if let endDateTxt = endDateTF.text, endDateTxt.isEmpty || endDateTxt == "" {
            DataManager.showAlert("", "End Date is mandatory")
            return
        }
        else {
            self.view.endEditing(true)

            ActivityIndicator.shared.show(self.view)


           let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
            let headerDict: [String:AnyObject] = ["Auth_token":header as AnyObject]
           
            let startDate = startDateTF.text
            let endDate = endDateTF.text
//            let duration = Calendar.current.dateComponents([.day], from: firstDate!, to: secondDate!).day
//            print(duration!)
           // let city = locationTextField.text
            let city = cityID
           // let durationString = String(duration!)
            let dic = ["city":city,"start_date":startDate,"end_date":endDate]
            
            DataManager.postAPIWithHeaderAndParameters(urlString: API.search, jsonString: dic as [String : AnyObject], header: headerDict, success: {
                success in

                print(success)
                
                if let responseArr = success["data"]  {
                    print(responseArr!)
                    ActivityIndicator.shared.hide()
                    if let responseObj = responseArr as? [[String : Any]], responseObj.count > 0 {
                        print(responseObj)
                        for dictObj: Dictionary<String, Any> in responseObj {
                        let package = Packages.init(packageId: dictObj["package_id"] as? String ?? "", packageName: dictObj["package_name"] as? String ?? "", packageCode: dictObj["package_code"] as? String ?? "", packageDescription: dictObj["package_description"] as? String ?? "", duration: dictObj["duration"] as? String ?? "", country: dictObj["package_country"] as? String ?? "",       state: dictObj["package_state"] as? String ?? "", city: dictObj["package_city"] as? String ?? "", location: dictObj["package_location"] as? String ?? "", rating: dictObj["rating"] as? String ?? "", status: dictObj["status"] as? String ?? "", price: dictObj["price"] as? String ?? "", image: dictObj["image"] as? String ?? "", favourite: dictObj["favourite"] as? String ?? "")
                        self.packageArray.append(package)
                       
                    }
                        self.searchLabel.isHidden=false
                        self.searchResultTabel.isHidden=false
                        self.searchResultTabel.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Package Not Found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                        self.present(alert, animated: true, completion:nil)
                        self.locationTextField.text = ""
                        self.startDateTF.text = ""
                        self.endDateTF.text = ""
                        self.searchLabel.isHidden=true
                        self.searchResultTabel.isHidden=true
                    }
                    print(self.packageArray)
                    
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
        
        
        
    }
    func loadCities(){
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["Auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.cities, header: headerDict, success: {
            success in
              if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                if let cities = response["cities"] {
                    print(cities)
                    for city in (cities as? [[String : Any]])! {
                        let cityObj = Cities.init(cityId: city["id"] as? String ?? "", cityCountry: city["country"] as? String ?? "", cityName: city["city"] as? String ?? "")
                        print(cityObj)
                        self.cityArray.append(cityObj)
                        
                        
                    }
                    print(self.cityArray.count)
                    for city in self.cityArray {
                        self.originalCityNamesArray.append(city.name)
                        self.cityNamesArray.append(city.name)
                    }
                    self.cityNameTblView.reloadData()
                }
            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
       
    }
    
    @objc func tapGestureCalled(_ sender: UITapGestureRecognizer) {
        guard let tap = sender as? UITapGestureRecognizer else {
            return
        }
        if (tap.view?.isEqual(cityNameTblView))! {
            cityNameTblView.isHidden = true
        }
         tapGesture.cancelsTouchesInView = false
    }
    
    //MARK: IBAction Methods
    @IBAction func backButtonTapped(_ sender: Any) {
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
    
   
    @IBAction func dateButtonTapped(_ sender: Any) {
        searchLabel.isHidden=true
        searchResultTabel.isHidden=true
        datePickerUp()
    }
    
   
    
    @IBAction func searchButtonTapped(_ sender: Any) {
       
        self.view.endEditing(true)
       // searchResultTabel.isHidden = false  //STATIC
        loadData() //DYNAMIC
    }
    //MARK: - Date Picker Data Source & Delegate
    func datePickerVw() {
        datePicker.datePickerMode = .date
        if type == 1 {
            datePicker.minimumDate = NSDate() as Date
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            datePicker.minimumDate = formatter.date(from: startDateTF.text!)

        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(doneClicked));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        startDateTF.inputAccessoryView = toolbar
        startDateTF.inputView = datePicker
        endDateTF.inputAccessoryView = toolbar
        endDateTF.inputView = datePicker
    }
    
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if type == 1 {
            startDateTF.text = formatter.string(from: datePicker.date)
        } else if type == 2 {
            endDateTF.text = formatter.string(from: datePicker.date)
        }

        self.view.endEditing(true)
    }
    
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    func datePickerUp() {
        if self.view.frame.origin.y != 0 {
            self.view.endEditing(true)
        }
        startDateTF.becomeFirstResponder()
        endDateTF.becomeFirstResponder()
    }
    
    //MARK: - UITextField Delegate
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        if startDateTF.text!.isEmpty && textField == endDateTF {
            let alert = UIAlertController(title: "Error", message: "Please Enter Start Date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
            self.present(alert, animated: true, completion:nil)
        } else {
        if textField == startDateTF  {
            type = 1
        } else {
            type = 2
        }
        self.datePickerVw()
        }

    }
   
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView Delegate & Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchResultTabel {
            return packageArray.count  // DYNAMIC
         //   return packageImageArray.count  //STATIC
        }
        else {
            return cityNamesArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if tableView == searchResultTabel {
            
            //DYNAMIC
            imagePath=packageArray[indexPath.row].image
            print(imagePath)
            cell.packageImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"))

            cell.packageNameLabel.text=packageArray[indexPath.row].packageName
            let rating = packageArray[indexPath.row].rating
            for (index, imageView) in [cell.star1Img, cell.star2Img, cell.star3Img, cell.star4Img, cell.star5Img].enumerated() {
                imageView?.image = getStarImage(starNumber: Int(index + 1), forRating: Int(rating)!)
            }
            let duration = Int(packageArray[indexPath.row].duration)
            if duration == 1 {
                cell.duration.text = "\(duration!)DAYS"
            } else {
                cell.duration.text = "\(duration!)DAYS/\(duration!-1)NIGHTS"
            }
            cell.packagePrice.text = "$\(packageArray[indexPath.row].price)"
            
            //STATIC
//            cell.packageImage.image = packageImageArray[indexPath.row]
//            cell.packageNameLabel.text = "HA LONG BAY"
//            cell.duration.text = "4 DAYS/ 3 NIGHTS"
//
            
            
            let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
            separatorLineView.backgroundColor = UIColor.groupTableViewBackground
            cell.contentView.addSubview(separatorLineView)
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
        } else {
            cell.cityNameLbl.text = cityNamesArray[indexPath.row]
        }
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchResultTabel {
            return 90
        } else {
            return 45
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchResultTabel {
            if let packageDetail = self.storyboard?.instantiateViewController(withIdentifier: "PackageDetailViewController") as? PackageDetailViewController {
                //packageDetail.packageImage=packageImageArray[indexPath.row]
                self.definesPresentationContext = true
                packageDetail.modalPresentationStyle = .overCurrentContext
                // self.navigationController?.pushViewController(packageDetail, animated: true)
                self.present(packageDetail, animated: false, completion: nil)
            }
        }
        else {
            locationTextField.text = cityNamesArray[indexPath.row]
            cityNameTblView.isHidden = true
            for cityIdToSearch in cityArray {
                if locationTextField.text == cityIdToSearch.name
                {
                    cityID = cityIdToSearch.id
                    break
                }
                
            }
        }
    }
  
    func getStarImage(starNumber: Int, forRating rating: Int) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else {
            return emptyStarImage
        }
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
