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

class MainViewController: UIViewController,GIDSignInDelegate, GIDSignInUIDelegate {
     override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate?
        
        GIDSignIn.sharedInstance().delegate=self
    }
    
    @IBAction func gmailLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        let loginManager = LoginManager()
       loginManager.logIn(readPermissions: [ReadPermission.userAboutMe, ReadPermission.email,ReadPermission.publicProfile ], viewController: self) { (loginResult) in
            print(loginResult)
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("user token \(accessToken)")
            }
        }
    }
    
    @IBAction func nextLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "dashboardvc") as? DashboardViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: vc!)
        
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
        print("User Object: \n\(user)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
