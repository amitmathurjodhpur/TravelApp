//
//  BookingNextViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 01/03/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class BookingNextViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var packageImageview: UIImageView!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var child3TextField: UITextField!
    @IBOutlet weak var child2TextField: UITextField!
    @IBOutlet weak var child1TextField: UITextField!
    @IBOutlet weak var paxTextField: UITextField!
    @IBOutlet var passportTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextView: UIView!
    var tapGesture = UITapGestureRecognizer()
    var packageImagePath: String = ""
    var datePicker:UIDatePicker!
    var flag:Bool!
    var duration: String = ""
    var rating: String = ""
    let fullStarImage = UIImage(named: "Star gold.png")
    let emptyStarImage = UIImage(named: "Star.png")
    //MARK: - view did load
    override func viewDidLoad() {
        packageImageview.sd_setImage(with: URL(string: packageImagePath), placeholderImage: UIImage(named: "placeholder.png"))
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let donebutton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([donebutton], animated: false)
        nameTextField.inputAccessoryView=toolBar
        emailTextField.inputAccessoryView=toolBar
        passportTextField.inputAccessoryView=toolBar
        paxTextField.inputAccessoryView=toolBar
        child1TextField.inputAccessoryView=toolBar
        child2TextField.inputAccessoryView=toolBar
        child3TextField.inputAccessoryView=toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        //Tap Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(BookingViewController.nextViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        nextView.addGestureRecognizer(tapGesture)
        nextView.isUserInteractionEnabled = true
        flag=false
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //MARK: - IBACTION METHODS
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- CUSTOM METHODS
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    
    // date Picker
    func datePickerVw(_ sender: UITextField)
    {
        flag=true
        // DatePicker
        datePicker=UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        dobTextField.inputView = self.datePicker
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BookingNextViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(BookingNextViewController.cancelDatePicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        dobTextField.inputAccessoryView = toolBar
      //  self.view.addSubview(datePicker)
      // datePicker.addTarget(self, action: #selector(BookingViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)

    }
    @objc func donedatePicker()
    {
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat="dd-MM-yyyy"
        dobTextField.text=dateFormatter.string(from: (datePicker as AnyObject).date)
        self.view.endEditing(true)
        flag=false
    }
    @objc func cancelDatePicker()
    {
        self.view.endEditing(true)
        flag=false
    }
    
    
    
    @objc func datePickerValueChanged()
    {
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat="dd-MM-yyyy"
        dobTextField.text=dateFormatter.string(from: (datePicker as AnyObject).date)
    }
    @objc func nextViewTapped(_ sender: UITapGestureRecognizer) {
        if let finalBookingVC = self.storyboard?.instantiateViewController(withIdentifier: "FinalBookingViewController") as? FinalBookingViewController {
            finalBookingVC.packageImagePath = packageImagePath
            self.present(finalBookingVC, animated: true, completion: nil)
        }
    }
    //MARK: - TEXTFIELD DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField==dobTextField
        {
            self.datePickerVw(textField)
            return true
        }
        textField.clearsOnBeginEditing=true
        return true
    }
    
    // MARK:- KEYBOARD METHODS
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if flag==false
            {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 100
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
