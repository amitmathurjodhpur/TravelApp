//
//  BookingViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 27/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var selectedPackageImageView: UIImageView!
    var packageImage:UIImage!
    var pickerView:UIPickerView!
    var datePickerView:UIDatePicker!
    var pickerData=["5 DAYS/ 4 NIGHTS","4 DAYD/ 3 NIGHTS","3 DAYS/ 2 NIGHTS","2 DAYS/ 1 NIGHTS"]
    var tapGesture = UITapGestureRecognizer()
    @IBOutlet weak var durationTextBox: UITextField!
    
    @IBOutlet weak var adultTextField: UITextField!
    
    @IBOutlet weak var hotelOptionLabel: UILabel!
    @IBOutlet weak var childrenTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var standardButton: UIButton!
    @IBOutlet weak var superiorButton: UIButton!
    @IBOutlet weak var deluxeButton: UIButton!
    
    @IBOutlet weak var nextView: UIView!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        selectedPackageImageView.image=packageImage
       self.pickerView = UIPickerView(frame:CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.size.width, height: 216))
        self.datePickerView=UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.width, height: 216))
        adultTextField.keyboardType=UIKeyboardType.numberPad
        childrenTextField.keyboardType=UIKeyboardType.numberPad
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        adultTextField.inputAccessoryView=toolBar
        childrenTextField.inputAccessoryView=toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    func pickUp(){
        // UIPickerView
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
            self.datePickerView?.datePickerMode = UIDatePickerMode.date
            datePickerView.addTarget(self, action: #selector(BookingViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            //  self.datePickerView.addTarget(self, action: #selector(datePickerValueChanged(picker:)), for: .valueChanged)
            
            // datePickerView.addTarget(self, action: Selector("datePickerValueChanged"), for: .valueChanged)
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
        if let BookingVC = self.storyboard?.instantiateViewController(withIdentifier: "BookingNextViewController") as? BookingNextViewController {
            BookingVC.packageImage=packageImage
            self.present(BookingVC, animated: true, completion: nil)
        }
    }
   /*
 MARK:- KEYBOARD METHODS
 */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
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
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
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
