//
//  SecondViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 12/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var currentSelectedBtnColor:UIColor!
    var unselectedColor:UIColor!
    var profileArray : [Profile] = []
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var userEmailTF: UITextField!
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var userGenderTF: UITextField!
    @IBOutlet weak var paypalUserEmail: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var termsCondLbl: UILabel!
    @IBOutlet weak var aboutVTLbl: UILabel!
    
    @IBOutlet weak var dropDownPicker: UIPickerView!
    
    @IBOutlet weak var countryCodePicker: UIPickerView!
    @IBOutlet weak var termsCondHeading: UILabel!
    @IBOutlet weak var aboutVTHeading: UILabel!
    @IBOutlet weak var paymentTable: UITableView!
    @IBOutlet weak var processBar: UIImageView!
    
    @IBOutlet weak var cancelledBtn: UIButton!
    @IBOutlet weak var failedBtn: UIButton!
    @IBOutlet weak var processedBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
   
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutTvView: UIView!
    @IBOutlet weak var aboutTvBtn: UIButton!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var userDetailView: UIView!
    
   
    @IBOutlet weak var paymentDetailView: UIView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
     var imagePath: String = ""
    var tapGesture = UITapGestureRecognizer()
     var list = ["MR", "MRS", "MISS", "MASTER"]
    var countryArray : [Country] = []
    var countryCode : String = ""
    
    @IBOutlet weak var userDetailScrollView: UIScrollView!
    
    @IBOutlet weak var viewInsideUserDetail: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    //MARK:- View Did Load
    override func viewDidLoad() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        appDelegate.isTabBarBtnPress=true
        currentSelectedBtnColor=processedBtn.titleLabel?.textColor
        unselectedColor=allBtn.titleLabel?.textColor
        userDetailView.isHidden=true
        aboutTvView.isHidden=true
        paymentTable.tableFooterView = UIView()
        editProfileBtn.isHidden=true
        signOutBtn.isHidden = true
        self.dropDownPicker.isHidden = true
        self.countryCodePicker.isHidden = true
        phoneNoTF.isUserInteractionEnabled=false
        userNameTF.isUserInteractionEnabled=false
        userGenderTF.isUserInteractionEnabled = false
        addressTF.isUserInteractionEnabled = false
        userEmailTF.isUserInteractionEnabled = false
        countryTF.isUserInteractionEnabled = false
        saveBtn.isUserInteractionEnabled = false
        userNameTF.frame=CGRect(x: 193, y: 217, width: 127, height: 20)
       // userImageView.isUserInteractionEnabled = false
        
        //Tap Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userImageTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        userImageView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        phoneNoTF.inputAccessoryView=toolBar
        phoneNoTF.keyboardType=UIKeyboardType.numberPad
        userNameTF.inputAccessoryView=toolBar
        addressTF.inputAccessoryView = toolBar
        currentPasswordTF.inputAccessoryView = toolBar
        newPasswordTF.inputAccessoryView = toolBar
        processBar.translatesAutoresizingMaskIntoConstraints=true
        processBar.frame=CGRect(x: 78, y: 0, width: 72, height: 6)
//        let device=UIDevice.current.name
//        if device == "iPhone Xʀ" {
//            processBar.translatesAutoresizingMaskIntoConstraints=true
//
//            processBar.frame=CGRect(x: 57, y: 0, width: 72, height: 6)
//
//        }
//        if device == "iPhone 8 Plus"  || device == "iPhone XS Max" || device == "iPhone 7 Plus" || device == "iPhone 6s Plus" {
//            processBar.translatesAutoresizingMaskIntoConstraints=true
//            processBar.frame=CGRect(x: 57, y: 0, width: 72, height: 6)
//        }
        loadCountryDetails()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.loadProfile()
        })
        loadProfile()
        loadAboutUs()
        super.viewDidLoad()
    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
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
        
        var topPoint1 = CGFloat()
        var height1 = CGFloat()
        for subview in viewInsideUserDetail.subviews {
            if subview.frame.origin.y > topPoint1 {
                topPoint1 = subview.frame.origin.y
                height1 = subview.frame.size.height
            }
        }
        let contentHeight1=height1+topPoint1
        userDetailScrollView.contentSize=CGSize(width: userDetailScrollView.frame.width, height: contentHeight1)
       // print(userDetailScrollView.contentSize.width)
        print(userDetailScrollView.contentSize.height)
       // userDetailScrollView.contentSize=CGSize(width: userDetailScrollView.frame.width, height: 460)
        
    }
    @objc func userImageTapped(_ sender: UITapGestureRecognizer)
    {
        let myImagePicker = UIImagePickerController()
        myImagePicker.delegate=self
        myImagePicker.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    //MARK:- load aboutUS and Terms and Condition
    func loadAboutUs()
    {
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.aboutUs, header: headerDict, success: {
            success in
            if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                if let aboutus = response["about_us"] as? String {
                   // print(aboutus)
                    self.aboutVTLbl.text = aboutus
                }
                if let termsCond = response["terms_and_condition"] as? String {
                   // print(termsCond)
                    self.termsCondLbl.text = termsCond
                }
                ActivityIndicator.shared.hide()

            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
    }
    
    func loadCountryDetails() {
        ActivityIndicator.shared.show(self.view)
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.country, header: headerDict, success: {
            success in
            ActivityIndicator.shared.hide()
            if let response = success["data"] as? [[String : Any]], response.count > 0 {
                for item in response {
                    let countryObj = Country.init(countryCode: item["country_code"] as? String ?? "", countryName: item["name"] as? String ?? "", countryOrigin: item["origin"] as? String ?? "")
                    self.countryArray.append(countryObj)
                }
                
            }
            self.countryCodePicker.reloadAllComponents()
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
    }
    
    func loadProfile()
    {
        ActivityIndicator.shared.show(self.view)

        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.profile, header: headerDict, success: {
            success in
            if let response = success["data"] as? Dictionary<String, Any>, response.count > 0 {
                if let msg = response["msg"] as? [String:Any], msg.count > 0 {
                    let profile = Profile.init(userId: msg["user_id"] as? String ?? "", userType: msg["user_type"] as? String ?? "", email: msg["email"] as? String ?? "", userName: msg["user_name"] as? String ?? "", password: msg["password"] as? String ?? "", status: msg["status"] as? String ?? "", dateOfBirth: msg["date_of_birth"] as? String ?? "", image: msg["image"] as? String ?? "", title: msg["title"] as? String ?? "", firstName: msg["first_name"] as? String ?? "", lastName: msg["last_name"] as? String ?? "", address: msg["address"] as? String ?? "", state: msg["state"] as? String ?? "", city: msg["city"] as? String ?? "", pinCode: msg["pin_code"] as? String ?? "", countryCode: msg["country_code"] as? String ?? "", countryName: msg["country_name"] as? String ?? "", phone: msg["phone"] as? String ?? "")
                  //  print(profile)
                    self.profileArray.append(profile)
                }
                self.imagePath=self.profileArray[0].image
                print(self.imagePath)
                self.userImageView.sd_setImage(with: URL(string: self.imagePath), placeholderImage: UIImage(named: "placeholder.png"))
                let gender = self.profileArray[0].title
                if gender == "1" {
                    self.userGenderTF.text = "MR"
                } else if gender == "2" {
                    self.userGenderTF.text = "MRS"
                } else if gender == "3" {
                    self.userGenderTF.text = "MISS"
                }else if gender == "4" {
                    self.userGenderTF.text = "MASTER"
                }
                let countryCode = self.profileArray[0].countryCode
                let countryName = self.checkCountry(countryCode)
                self.countryTF.text = countryName
              // self.phoneNoTF.text = "+" + countryCode + self.profileArray[0].phone
                self.phoneNoTF.text =  self.profileArray[0].phone

                self.userEmailTF.text = self.profileArray[0].email
                self.paypalUserEmail.text = self.profileArray[0].email
                self.userEmailLbl.text = self.profileArray[0].email
                let username = "\(self.profileArray[0].firstName ) \(self.profileArray[0].lastName)"
               // let username = userstring + "" + self.profileArray[0].lastName
              //  print(username)
                self.userNameTF.text = username
                self.addressTF.text = self.profileArray[0].address
            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
    }
    
    func checkCountry(_ code : String) -> String
    {
        var countryName: String = ""
        let Code = "+" + code
        for item in countryArray {
            if Code == item.code {
                countryName = item.name
                break
            }
        }
        return countryName
    }
    
    //MARK:- IBAction Methods
   
    @IBAction func searchBtnTapped(_ sender: Any) {
//        if let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
//            self.definesPresentationContext = true
//            searchVC.modalPresentationStyle = .overCurrentContext
//            self.present(searchVC, animated: true, completion: nil)
//            
//        }
    }
    @IBAction func saveProfileTapped(_ sender: Any) {
        ActivityIndicator.shared.show(self.view)
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        let gender = userGenderTF.text?.uppercased()
        var title = "1"
        if gender == "MR" {
            title = "1"
        } else if gender == "MRS" {
            title = "2"
        } else if gender == "MISS" {
            title = "3"
        } else if gender == "MASTER" {
            title = "4"
        }
        let fullName = userNameTF.text
        var components = fullName!.components(separatedBy: " ")
        var firstName : String = ""
        var lastName : String = ""
        if(components.count > 0)
        {
             firstName = components.removeFirst()
             lastName = components.joined(separator: " ")
            print(firstName)
            print(lastName)
        }
        countryCode.remove(at: countryCode.startIndex)
        let phoneNO = phoneNoTF.text
        print(phoneNO!)
        let address = addressTF.text
        print(address!)
        let userID = self.profileArray[0].userId
        let currentPassword = currentPasswordTF.text
        let newPassword = newPasswordTF.text
        let dic = ["first_name" : firstName, "last_name" : lastName, "country_code" :countryCode, "phone" :phoneNO, "address" : address]
//         let dic = ["first_name" : firstName, "last_name" : lastName, "country_code" :countryCode, "phone" :phoneNO, "address" : address, "user_id" : userID, "current_password" : currentPassword, "new_password" : newPassword]

//        let dic = ["title" : title, "first_name" : firstName, "last_name" : lastName, "country_code" :countryCode, "phone" :phoneNO, "address" : address, "user_id" : userID, "current_password" : currentPassword, "new_password" : newPassword]

        if let imageObj = self.userImageView.image, let imageData = imageObj.pngData() as NSData? {

            let data = imageData
            DataManager.postMultipartDataWithHeaderAndParameters(urlString: API.updateProfile, imageData: ["image": data] as [String : Data], params: dic as [String : AnyObject], header: headerDict,  success: {
                success in
                ActivityIndicator.shared.hide()
                if let response = success["data"] as? Dictionary<String, AnyObject> , response.count > 0 {
                    print(response)
                    if let status = success["status"] as? Int, status == 1 {
                        self.phoneNoTF.isUserInteractionEnabled=false
                        self.userNameTF.isUserInteractionEnabled=false
                        self.userGenderTF.isUserInteractionEnabled = false
                        self.addressTF.isUserInteractionEnabled = false
                        self.userEmailTF.isUserInteractionEnabled = false
                        self.currentPasswordTF.isUserInteractionEnabled = false
                        self.newPasswordTF.isUserInteractionEnabled = false
                        self.countryTF.isUserInteractionEnabled = false
                        self.saveBtn.isUserInteractionEnabled = false
                        self.imagePath = (response["image"] as? String)!
                        print(self.imagePath)
                        self.userImageView.sd_setImage(with: URL(string: self.imagePath), placeholderImage: UIImage(named: "placeholder.png"))
                        let gender = response["title"] as? String
                        if gender == "1" {
                            self.userGenderTF.text = "MR"
                        } else if gender == "2" {
                            self.userGenderTF.text = "MRS"
                        } else if gender == "3" {
                            self.userGenderTF.text = "MISS"
                        }else if gender == "4" {
                            self.userGenderTF.text = "MASTER"
                        }
                        let countryCode = self.profileArray[0].countryCode
                      //  self.phoneNoTF.text = "+" + countryCode + (response["phone"] as? String)!
                        self.phoneNoTF.text = (response["phone"] as? String)!

                        let username = "\(response["first_name"] as? String ?? "") \(response["last_name"] as? String ?? "")"

                        print(username)
                        self.userNameTF.text = username
                        self.addressTF.text = response["address"] as? String
                        self.currentPasswordTF.text = ""
                        self.newPasswordTF.text = ""
                    }

                }
            }, failure: {
                fail in
                ActivityIndicator.shared.hide()
            })
        }
    }
        
    
    
  
    @IBAction func savePasswordBtnTapped(_ sender: Any) {
       
        if let currentPassword=currentPasswordTF.text, currentPassword.isEmpty || currentPassword == "" {
            self.showAlert("", "Current Password is mandatory")
            return
        } else if let newPassword = newPasswordTF.text, newPassword.isEmpty || newPassword == "" {
            self.showAlert("", "Password is mandatory")
            return
        } else {
            ActivityIndicator.shared.show(self.view)
            let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
            let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
            let dic = ["current_password":currentPasswordTF.text ,"new_password":newPasswordTF.text]
            DataManager.postAPIWithHeaderAndParameters(urlString: API.changePassword, jsonString: dic as [String : AnyObject], header: headerDict, success: {
                success in
                if let response = success["data"] as? Dictionary<String, AnyObject> , response.count > 0 {
                    print(response)
                    ActivityIndicator.shared.hide()

                    if let msg = response["msg"] as? String {
                        self.showAlert("", msg)
                    }

                }
            }, failure: {
                failure in
                ActivityIndicator.shared.hide()
                print(failure)
            })
        }
    }
   
    @IBAction func signOutBtnTapped(_ sender: Any) {
        ActivityIndicator.shared.show(self.view)
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:AnyObject] = ["auth_token":header as AnyObject]
        DataManager.getAPIWithHeader(urlString: API.logOut, header: headerDict, success: {
            success in
            ActivityIndicator.shared.hide()
            if let response = success["data"] as? String {
               print(response)
                if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
//                    self.definesPresentationContext = true
//                    loginVC.modalPresentationStyle = .overCurrentContext
                    UserDefaults.standard.set(nil, forKey: AppKey.AuthorizationKey)
                    UserDefaults.standard.synchronize()
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.isNavigationBarHidden = true
                    UIApplication.shared.keyWindow?.rootViewController = navigationController
                    
                    //self.present(loginVC, animated: true, completion: nil)
                }
            }
        }, failure: {
            failure in
            ActivityIndicator.shared.hide()
            print(failure)
        })
    }
   
    @IBAction func editProfileTapped(_ sender: Any) {
        phoneNoTF.isUserInteractionEnabled=true
        userNameTF.isUserInteractionEnabled=true
        userGenderTF.isUserInteractionEnabled = true
        addressTF.isUserInteractionEnabled = true
        userImageView.isUserInteractionEnabled = true
        currentPasswordTF.isUserInteractionEnabled = true
        newPasswordTF.isUserInteractionEnabled = true
        countryTF.isUserInteractionEnabled = true
        saveBtn.isUserInteractionEnabled = true
        userNameTF.becomeFirstResponder()
      //  userImageView.image = UIImage.init(named: "placeholder.png")
        //userEmailTF.isUserInteractionEnabled = true
        //passwordTF.isUserInteractionEnabled = true
    }
   
   

    @IBAction func profileOptionBtnTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        switch button.tag {
        case 11:
            userDetailView.isHidden=false
            aboutTvView.isHidden=true
            paymentDetailView.isHidden = true
            signOutBtn.isHidden = false
            profileBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            paymentBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            aboutTvBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            profileBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            paymentBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            aboutTvBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            editProfileBtn.isHidden=false
            phoneNoTF.isUserInteractionEnabled=false
            userNameTF.isUserInteractionEnabled=false
           
            userNameTF.layer.frame=CGRect(x: 230, y: 217, width: 127, height: 20)

        case 12:
            userDetailView.isHidden=true
            aboutTvView.isHidden=true
            paymentDetailView.isHidden = false
            editProfileBtn.isHidden=true
            signOutBtn.isHidden = true
            phoneNoTF.isUserInteractionEnabled=false
            userNameTF.isUserInteractionEnabled=false
            userNameTF.layer.frame=CGRect(x: 193, y: 217, width: 127, height: 20)
            profileBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            paymentBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            aboutTvBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            profileBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            paymentBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            aboutTvBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)

        case 13:
            userDetailView.isHidden=true
            aboutTvView.isHidden=false
            paymentDetailView.isHidden = true
            editProfileBtn.isHidden=true
            phoneNoTF.isUserInteractionEnabled=false
            userNameTF.isUserInteractionEnabled=false
            signOutBtn.isHidden = true
            userNameTF.layer.frame=CGRect(x: 193, y: 217, width: 127, height: 20)
            profileBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            paymentBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            aboutTvBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            profileBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            paymentBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            aboutTvBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)

        default:
            userDetailView.isHidden=true

        }
    }
    @IBAction func paymentOptionBtnTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 1:
            processBar.frame=CGRect(x: 0, y: 0, width: 50, height: 6)
            allBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            processedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            failedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)

            allBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            processedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            failedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
        case 2:
            processBar.frame=CGRect(x: 78, y: 0, width: 72, height: 6)
            allBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            processedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            failedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            
            allBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            processedBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            failedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
        case 3:
            processBar.translatesAutoresizingMaskIntoConstraints=true
            processBar.frame=CGRect(x: 180, y: 0, width: 50, height: 6)
//            let device=UIDevice.current.name
//            if device == "iPhone 8 Plus" ||  device == "iPhone XS Max" || device == "iPhone 7 Plus" || device == "iPhone 6s Plus" || device == "iPhone Xʀ" {
//                processBar.translatesAutoresizingMaskIntoConstraints=true
//                processBar.frame=CGRect(x: 168, y: 0, width: 50, height: 6)
//            } else {
//                processBar.frame=CGRect(x: 145, y: 0, width: 50, height: 6)
//            }
            allBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            processedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            failedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            cancelledBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            
            allBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            processedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            failedBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            cancelledBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
        case 4:
            processBar.translatesAutoresizingMaskIntoConstraints=true
            processBar.frame=CGRect(x: 255, y: 0, width: 72, height: 6)
//            let device=UIDevice.current.name
//            if device == "iPhone 8 Plus" || device == "iPhone Xʀ" || device == "iPhone XS Max" || device == "iPhone 7 Plus" || device == "iPhone 6s Plus" {
//                processBar.translatesAutoresizingMaskIntoConstraints=true
//                processBar.frame=CGRect(x: 265, y: 0, width: 72, height: 6)
//            } else {
//                processBar.frame=CGRect(x: 225, y: 0, width: 72, height: 6)
//            }
            allBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            processedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            failedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            
            allBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            processedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            failedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
        default:
            processBar.frame=CGRect(x: 57, y: 0, width: 72, height: 6)
            allBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            processedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            failedBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            
            allBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            processedBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            failedBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
        }
    }
    
    // MARK:- UITableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.processedPackageLabel.text="Ha Long Bay"
        cell.processedTaxLbl.text="Includes x% tax of 100"
        cell.processedTotalAmount.text="$ 2500"
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        /// change size as you need.
        separatorLineView.backgroundColor = self.view.backgroundColor
        // you can also put image here
        cell.contentView.addSubview(separatorLineView)
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK:- UIIMAGEPICKER DELEGATES
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // Local variable inserted by Swift 4.2 migrator.
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]
            as? UIImage else {
                return
        }
        userImageView.image=image
        userImageView.backgroundColor=UIColor.clear
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    //MARK:- PickerView Delegates
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == dropDownPicker {
            return list.count
        } else {
            return countryArray.count

        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
     //   print(countryArray.count)
        if pickerView == countryCodePicker {
            print(countryArray[row].name)
            return countryArray[row].name

        } else {
            return list[row]

        }
        
        
//        if pickerView == dropDownPicker {
//            return list[row]
//        } else {
//            print(countryArray[row].name)
//            return countryArray[row].name
//
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropDownPicker {
            self.userGenderTF.text = self.list[row]
            self.dropDownPicker.isHidden = true
        } else if pickerView == countryCodePicker {
            self.countryCodePicker.isHidden = true
            self.countryTF.text = self.countryArray[row].name
           countryCode = countryArray[row].code
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.userGenderTF {
            self.dropDownPicker.isHidden = false
            //if you don't want the users to se the keyboard type:
            
          
        } else if textField == self.countryTF {
            self.countryCodePicker.isHidden = false
        }
          textField.endEditing(true)
    }
   /* MARK:- KEYBOARD METHODS
    */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
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
    //MARK:- Helper function inserted by Swift 4.2 migrator.

    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}

