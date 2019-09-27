//
//  BookingViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 27/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var packageNameLbl: UILabel!
    @IBOutlet weak var selectedPackageImageView: UIImageView!
    var packageImagePath: String = ""
    var duration: String = ""
    var rating: String = ""
    var pickerView:UIPickerView!
    var datePickerView:UIDatePicker!
    var pickerData=["5 DAYS/ 4 NIGHTS","4 DAYD/ 3 NIGHTS","3 DAYS/ 2 NIGHTS","2 DAYS/ 1 NIGHTS"]
    var tapGesture = UITapGestureRecognizer()
    let fullStarImage = UIImage(named: "Star gold.png")
    let emptyStarImage = UIImage(named: "Star.png")
    @IBOutlet weak var durationTextBox: UITextField!
    @IBOutlet weak var adultTextField: UITextField!
    @IBOutlet weak var hotelOptionLabel: UILabel!
    @IBOutlet weak var childrenTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var standardButton: UIButton!
    @IBOutlet weak var superiorButton: UIButton!
    @IBOutlet weak var deluxeButton: UIButton!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star1Img: UIImageView!
    //MARK: - View Did Load
    override func viewDidLoad() {
        
       
        adultTextField.keyboardType=UIKeyboardType.numberPad
        childrenTextField.keyboardType=UIKeyboardType.numberPad
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        adultTextField.inputAccessoryView=toolBar
        childrenTextField.inputAccessoryView=toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //Tap Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(BookingViewController.nextViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        nextView.addGestureRecognizer(tapGesture)
        nextView.isUserInteractionEnabled = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - IBACTION METHODS
    @IBAction func durationDropDownButtonTapped(_ sender: Any) {
       self.pickUp()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateDropDownButtonTapped(_ sender: Any) {
        self.datePickerUp()
    }
    
    @IBAction func hotelOptionButtonTapped(_ sender: Any) {
        
        guard let button = sender as? UIButton else {
            return
        }
        if button.backgroundColor != UIColor.white
        {
            let currentColor:UIColor!=button.backgroundColor

            //  currentColor=button.backgroundColor
            switch button {
            case deluxeButton:
                hotelOptionLabel.text="5 Star Hotel Selected"
                deluxeButton.backgroundColor=UIColor.white
                deluxeButton.layer.borderWidth=1.0
                superiorButton.layer.borderWidth=0
                standardButton.layer.borderWidth=0
                superiorButton.backgroundColor=currentColor
                standardButton.backgroundColor=currentColor
            case superiorButton:
                hotelOptionLabel.text="4 Star Hotel Selected"
                superiorButton.backgroundColor=UIColor.white
                superiorButton.layer.borderWidth=1.0
                deluxeButton.layer.borderWidth=0
                standardButton.layer.borderWidth=0
                deluxeButton.backgroundColor=currentColor
                standardButton.backgroundColor=currentColor
            case standardButton:
                hotelOptionLabel.text="3 Star Hotel Selected"
                standardButton.backgroundColor=UIColor.white
                standardButton.layer.borderWidth=1.0
                superiorButton.layer.borderWidth=0
                deluxeButton.layer.borderWidth=0
                superiorButton.backgroundColor=currentColor
                deluxeButton.backgroundColor=currentColor
            default:
                hotelOptionLabel.text="Select a Hotel"
            }
        }
    }
    
  
        
    //MARK: - CUSTOM METHODS
    func setUpUI() {
        selectedPackageImageView.sd_setImage(with: URL(string: packageImagePath), placeholderImage: UIImage(named: "placeholder.png"))
              self.pickerView = UIPickerView(frame:CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.size.width, height: 216))
               self.datePickerView=UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.width, height: 216))
        
        for (index, imageView) in [star1Img, star2Img, star3Img, star4Img, star5Img].enumerated() {
            imageView?.image = getStarImage(starNumber: Int(index + 1), forRating: Int(rating)!)
        }
        let dur = Int(duration)
        if dur == 1 {
            durationLbl.text = "\(dur ?? 0)DAY"
        } else {
            durationLbl.text = "\(dur ?? 0)DAYS/\((dur ?? 0)-1)NIGHTS"
        }
    }
    func pickUp(){
        // UIPickerView
        if self.view.frame.origin.y != 0 {
            self.view.endEditing(true)
        }
        if datePickerView.isDescendant(of: self.view)
        {
            datePickerView.removeFromSuperview()
        }
        if pickerView.isDescendant(of: self.view){
            pickerView.removeFromSuperview()
        }
        else{
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.pickerView.backgroundColor = UIColor.white
            self.view.addSubview(pickerView)
            durationTextBox.inputView = self.pickerView
        }
    }
    
    func datePickerUp() {
        if self.view.frame.origin.y != 0 {
            self.view.endEditing(true)
        }
        if pickerView.isDescendant(of: self.view)
        {
            pickerView.removeFromSuperview()
        }
        if datePickerView.isDescendant(of: self.view)
        {
            datePickerView.removeFromSuperview()
        }
        else
        {
            self.datePickerView?.backgroundColor = UIColor.white
            self.datePickerView?.datePickerMode = UIDatePicker.Mode.date
            datePickerView.addTarget(self, action: #selector(BookingViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
            view.addSubview(self.datePickerView)
            dateTextField.inputView=self.datePickerView
            
        }
        
    }
    
    @objc func datePickerValueChanged()
    {
        print("dateSelector Called")
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat="dd-MM-yyyy"
        dateTextField.text=dateFormatter.string(from: (datePickerView as AnyObject).date)
    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
       
    }
    @objc func nextViewTapped(_ sender: UITapGestureRecognizer) {
        if let BookingNextVC = self.storyboard?.instantiateViewController(withIdentifier: "BookingNextViewController") as? BookingNextViewController {
            BookingNextVC.packageImagePath = packageImagePath
            self.present(BookingNextVC, animated: true, completion: nil)
        }
    }
   /*
 MARK:- KEYBOARD METHODS
 */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    /*
     //MARK:- PickerView Delegates
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.durationTextBox.text = pickerData[row]
    }
    
    /*
 // MARK:- TextFieldDelegates
    */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag==1||textField.tag==2)
        {
           textField.clearsOnBeginEditing=true
            if datePickerView.isDescendant(of: self.view)
            {
                datePickerView.removeFromSuperview()
            }
            if pickerView.isDescendant(of: self.view){
                pickerView.removeFromSuperview()
            }
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    //MARK: getStarImage
    func getStarImage(starNumber: Int, forRating rating: Int) -> UIImage {
        if rating >= starNumber {
            return fullStarImage ?? UIImage()
        } else {
            return emptyStarImage ?? UIImage()
        }
    }
    
}
