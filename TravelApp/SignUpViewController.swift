//
//  SignUpViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 06/03/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var contactNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var uploadPhotoLBL: UILabel!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    var selectedImage:UIImage!
    var userName:String!
    var email:String!
    var phoneNumber:String!
    //MARK: View did load
    override func viewDidLoad() {
        uploadPhotoLBL.isHidden=true
        photoImageView.isHidden=true
        uploadBtn.isHidden=true
      let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
       firstNameTF.inputAccessoryView=toolBar
        lastNameTF.inputAccessoryView=toolBar
        emailTF.inputAccessoryView=toolBar
        passwordTF.inputAccessoryView=toolBar
        contactNumberTF.inputAccessoryView=toolBar
        confirmPasswordTF.inputAccessoryView=toolBar
        contactNumberTF.keyboardType=UIKeyboardType.numberPad
        emailTF.keyboardType=UIKeyboardType.emailAddress
        let bottomLine1 = CALayer()
        bottomLine1.frame=CGRect(x: 0, y: firstNameTF.frame.height-1, width: firstNameTF.frame.width, height: 1)
        bottomLine1.backgroundColor=UIColor.white.cgColor
        firstNameTF.borderStyle = UITextField.BorderStyle.none
        firstNameTF.layer.addSublayer(bottomLine1)
        let bottomLine2 = CALayer()
        bottomLine2.frame=CGRect(x: 0, y: lastNameTF.frame.height-1, width: lastNameTF.frame.width, height: 1)
        bottomLine2.backgroundColor=UIColor.white.cgColor
        lastNameTF.borderStyle = UITextField.BorderStyle.none
        lastNameTF.layer.addSublayer(bottomLine2)
        let bottomLine3 = CALayer()
        bottomLine3.frame=CGRect(x: 0, y: emailTF.frame.height-1, width: emailTF.frame.width, height: 1)
        bottomLine3.backgroundColor=UIColor.white.cgColor
        emailTF.borderStyle=UITextField.BorderStyle.none
        emailTF.layer.addSublayer(bottomLine3)
        let bottomLine4 = CALayer()
        bottomLine4.frame=CGRect(x: 0, y: passwordTF.frame.height-1, width: passwordTF.frame.width, height: 1)
        bottomLine4.backgroundColor=UIColor.white.cgColor
        passwordTF.borderStyle = UITextField.BorderStyle.none
        passwordTF.layer.addSublayer(bottomLine4)
        let bottomLine5 = CALayer()
        bottomLine5.frame=CGRect(x: 0, y: confirmPasswordTF.frame.height-1, width: confirmPasswordTF.frame.width, height: 1)
        bottomLine5.backgroundColor=UIColor.white.cgColor
        confirmPasswordTF.borderStyle = UITextField.BorderStyle.none
        confirmPasswordTF.layer.addSublayer(bottomLine5)
        let bottomLine6 = CALayer()
        bottomLine6.frame=CGRect(x: 0, y: contactNumberTF.frame.height-1, width: contactNumberTF.frame.width, height: 1)
        bottomLine6.backgroundColor=UIColor.white.cgColor
        contactNumberTF.borderStyle = UITextField.BorderStyle.none
        contactNumberTF.layer.addSublayer(bottomLine6)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        super.viewDidLoad()

    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let myImagePicker = UIImagePickerController()
        myImagePicker.delegate=self
        myImagePicker.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if firstNameTF.text! == "" || lastNameTF.text! == "" || emailTF.text! == "" || contactNumberTF.text == "" || passwordTF.text == "" {
            let alert = UIAlertController(title: "", message: "All fields are required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.signUpCall()
        }
        
        
    }
    func signUpCall() {
        ActivityIndicator.shared.show(self.view)
        if let firstName = firstNameTF.text, let lastName = lastNameTF.text, let mobileNo = contactNumberTF.text, let emailId = emailTF.text, let password = passwordTF.text, let confirmPassword = confirmPasswordTF.text {
            let dic = ["first_name":firstName ,"last_name":lastName, "email":emailId ,"password":password, "phone":mobileNo,"confirm_password":confirmPassword]
            DataManager.postAPIWithParameters(urlString: API.register , jsonString: dic as [String : AnyObject], success: { success in
                ActivityIndicator.shared.hide()
                if let response = success["status"] as? Int, response == 200, let message = success["data"] as? [String:Any] {
                    if let msg = message["msg"] as? String {
                        ActivityIndicator.shared.hide()
                    self.showAlert("Travel App", msg)
                    
                    }
                }
            }, failure: {
                failure in
                ActivityIndicator.shared.hide()
                print(failure)
            })
        }
    }
//    func signUpCall()
//    {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "dashboardvc") as? DashboardViewController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: vc!)
//    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    
    func showAlert(_ title:String?,_ message:String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     MARK:- KEYBOARD METHODS
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height-100
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
        photoImageView.image=image
        photoImageView.backgroundColor=UIColor.clear
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)

    }
    //MARK:- TextField Delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag==1 {
        }
        return true
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
