//
//  MainViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 15/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import Alamofire


class MainViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: AppKey.AuthorizationKey) != nil {
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "dashboardvc") as? DashboardViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: vc!)
        } else {
            //GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance().delegate=self
            let toolBar=UIToolbar()
            toolBar.sizeToFit()
            let doneButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
            toolBar.setItems([doneButton], animated: false)
            emailTextField.inputAccessoryView=toolBar
            passwordTextField.inputAccessoryView=toolBar
            let bottomLine1 = CALayer()
            bottomLine1.frame=CGRect(x: 0, y: emailTextField.frame.height-1, width: emailTextField.frame.width, height: 1)
            bottomLine1.backgroundColor=UIColor.white.cgColor
            emailTextField.borderStyle = UITextField.BorderStyle.none
            emailTextField.layer.addSublayer(bottomLine1)
            let bottomLine2 = CALayer()
            bottomLine2.frame=CGRect(x: 0, y: emailTextField.frame.height-1, width: emailTextField.frame.width, height: 1)
            bottomLine2.backgroundColor=UIColor.white.cgColor
            passwordTextField.borderStyle=UITextField.BorderStyle.none
            passwordTextField.layer.addSublayer(bottomLine2)
            
        }
        
    }
    
   
    @objc func doneClicked()
    {
        self.view.endEditing(true)
        
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func signUpTapped(_ sender: Any) {
         if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    @IBAction func gmailLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [Permission.userAboutMe, Permission.email,Permission.publicProfile ], viewController: self) { (loginResult) in
            print(loginResult)
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, let accessToken):
                print("user token \(accessToken)")
            }
        }
    }
    
    @IBAction func nextLogin(_ sender: Any) {
        
        // DYNAMIC APPROACH
        
        if let emailTxt=emailTextField.text, emailTxt.isEmpty || emailTxt == "" {
            self.showAlert("", "Email is mandatory")
            return
        } else if let passwordTxt = passwordTextField.text, passwordTxt.isEmpty || passwordTxt == "" {
            self.showAlert("", "Password is mandatory")
            return
        } else if let emailTxt=emailTextField.text,!isValidEmail(testStr: emailTxt) {
            self.showAlert("", "Invalid Email-Id")
        } else {
            self.view.endEditing(true)
            ActivityIndicator.shared.show(self.view)
           let dic = ["username":emailTextField.text ,"password":passwordTextField.text]

            DataManager.postAPIWithParameters(urlString: API.logIn , jsonString: dic as [String : AnyObject], success: {
                success in
                if let response = success["status"] as? Int, response == 200, let data = success["data"] as? Dictionary<String, AnyObject> {
                    print(response)
                    let Token = data["auth_token"] as? String
                    ActivityIndicator.shared.hide()
                    // Authorisation User
                    UserDefaults.standard.set(Token, forKey: AppKey.AuthorizationKey)
                    UserDefaults.standard.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "dashboardvc") as? DashboardViewController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: vc!)
                } else {
                        let alert = UIAlertController(title: "Error", message: "Invalid Authorization", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                        self.present(alert, animated: true, completion: {[weak self] in
                            self?.emailTextField.text = ""
                            self?.passwordTextField.text = ""
                        })
                        return
                    }

            }, failure: {
                    failure in
                    ActivityIndicator.shared.hide()
                    print(failure)
            })
            emailTextField.text = ""
            passwordTextField.text = ""
        
        // STATIC APPROACH
        
//            let vc = storyboard?.instantiateViewController(withIdentifier: "dashboardvc") as? DashboardViewController
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: vc!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //GIDSignInDelegates
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error=error {
            print(error.localizedDescription)
            print("error")
            return
        }
        //let userId = user.userID                  // For client-side use only!
        //let idToken = user.authentication.idToken // Safe to send to the server
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
        
       
    }
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    private func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
        //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
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
    // MARK: Validate Email
    func isValidEmail(testStr:String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}
