//
//  ForgetPasswordViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 12/05/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        emailTextField.inputAccessoryView=toolBar
        let bottomLine1 = CALayer()
        bottomLine1.frame=CGRect(x: 0, y: emailTextField.frame.height-1, width: emailTextField.frame.width, height: 1)
        bottomLine1.backgroundColor=UIColor.white.cgColor
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(bottomLine1)

        // Do any additional setup after loading the view.
    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if let emailTxt=emailTextField.text, emailTxt.isEmpty || emailTxt == "" {
            self.showAlert("", "Email is mandatory")
            return
        }else if let emailTxt=emailTextField.text,!isValidEmail(testStr: emailTxt) {
            self.showAlert("", "Invalid Email-Id")
        } else {
            if let emailId = emailTextField.text {
                let dic = ["email":emailId]
                ActivityIndicator.shared.show(self.view)

                DataManager.postAPIWithParameters(urlString: API.forgotPassword , jsonString: dic as [String : AnyObject], success: { success in
                    ActivityIndicator.shared.hide()
                    if let message = success["data"] as? String {
                        self.showAlert("Travel App", message)
                    }
                    
                }, failure: {
                    failure in
                    ActivityIndicator.shared.hide()
                    print(failure)
                })
            }
            emailTextField.text = ""
        }
    }
    func showAlert(_ title:String?,_ message:String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}
