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
    var packageImage:UIImage!
    var datePickerView:UIDatePicker!
    var datePickerContainer:UIView!

    //MARK: - view did load
    override func viewDidLoad() {
        packageImageview.image=packageImage
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        nameTextField.inputAccessoryView=toolBar
        emailTextField.inputAccessoryView=toolBar
        passportTextField.inputAccessoryView=toolBar
        paxTextField.inputAccessoryView=toolBar
        child1TextField.inputAccessoryView=toolBar
        child2TextField.inputAccessoryView=toolBar
        child3TextField.inputAccessoryView=toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.datePickerView=UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 216))
        self.datePickerContainer=UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.height-200, width: self.view.frame.width, height: 300))
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
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- CUSTOM METHODS
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    func datePickerUp() {
        //Create the view
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        doneButton.addTarget(self, action: #selector(self.datePickerDown), for: UIControlEvents.touchUpInside)
        doneButton.frame    = CGRect(x: 0, y: 0, width: 70, height: 35)
        
        datePickerContainer.addSubview(doneButton)
        self.datePickerView?.backgroundColor = UIColor.white
        self.datePickerView?.datePickerMode = UIDatePickerMode.date
        datePickerView.addTarget(self, action: #selector(BookingViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        datePickerContainer?.backgroundColor = UIColor.white
        datePickerContainer?.addSubview(datePickerView)
        
//        let toolBar=UIToolbar()
//        toolBar.sizeToFit()
//        toolBar.barTintColor=UIColor.white
//        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.datePickerDown))
//        toolBar.setItems([doneButton], animated: true)
        
        
        
        //datePickerContainer?.addSubview(toolBar)
        dobTextField.inputView=datePickerView
        self.view.addSubview(datePickerContainer!)
        
        
        
    }
    
    @objc func datePickerDown()
    {
        datePickerContainer.removeFromSuperview()
    }
    @objc func datePickerValueChanged()
    {
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat="dd-MM-yyyy"
        dobTextField.text=dateFormatter.string(from: (datePickerView as AnyObject).date)
    }
    @objc func nextViewTapped(_ sender: UITapGestureRecognizer) {
        if let BookingVC = self.storyboard?.instantiateViewController(withIdentifier: "FinalBookingViewController") as? FinalBookingViewController {
            BookingVC.packageImage=packageImage
            self.present(BookingVC, animated: true, completion: nil)
        }
    }
    //MARK: - TEXTFIELD DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField==dobTextField
        {
            self.datePickerUp()
            return false
        }
        textField.clearsOnBeginEditing=true
        return true
    }
    
    // MARK:- KEYBOARD METHODS
    
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
