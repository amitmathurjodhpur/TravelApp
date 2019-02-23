//
//  SecondViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 12/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import GoogleSignIn


class ProfileViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        GIDSignIn.sharedInstance().uiDelegate=self as GIDSignInUIDelegate
        GIDSignIn.sharedInstance().delegate=self
        let googleSignInButton=GIDSignInButton()
        googleSignInButton.center=view.center
        view.addSubview(googleSignInButton)
        
        
        
    }

    //GIDSignInDelegates
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error=error
        {
            print(error.localizedDescription)
            return
        }
       // userDetails.text=user.profile.name
        //  _Id = user.userID                  // For client-side use only!
       //  let idToken = user.authentication.idToken // Safe to send to the server
        // let fullName = user.profile.name
        // let givenName = user.profile.givenName
        // let familyName = user.profile.familyName
       //  let email = user.profile.email
        
        
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


}

