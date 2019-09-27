//
//  ActivityIndicator.swift
//  TravelApp
//
//  Created by Amit Mathur on 05/04/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import Foundation
import UIKit

public class ActivityIndicator: UIView {
    
    static let shared = ActivityIndicator()
    
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var textLabel: UILabel = UILabel()
    var loadingImage: UIImageView = UIImageView()
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public func show(_ view: UIView, _ message: String? = nil, _ applyOnWindow: Bool = true)  {
        DispatchQueue.main.async {
            self.appDelegate.window!.isUserInteractionEnabled = !applyOnWindow
            self.frame = view.frame
            self.frame.origin.y = view.frame.origin.y
            self.frame.size.height = view.frame.size.height+20
            self.center = self.center
            self.backgroundColor = .clear
            
//            self.textLabel.frame = CGRect(x:0, y: 80, width:self.loadingView.frame.size.width, height:40)
//            self.textLabel.textColor = UIColor.white
//            self.textLabel.text = message
//            self.textLabel.font.withSize(18)
//            self.textLabel.numberOfLines = 0
//            self.textLabel.textAlignment = NSTextAlignment.center
//            self.loadingView.addSubview(self.textLabel)
            self.loadingView.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height)
           

     
            
        
            self.loadingView.center = view.center
           // self.loadingView.backgroundColor = UIColor.clear
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            //          self.loadingView.backgroundColor = UIColor.color(100, 100, 100, 1.0)
            self.loadingView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
            self.activityIndicator.frame = CGRect(x:self.loadingView.frame.size.width / 2 - 40, y:self.loadingView.frame.size.height / 2 , width:80, height:80)
            
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.color = UIColor.white//UIColor.color(191, 191, 191)
            self.activityIndicator.startAnimating()
            self.loadingView.addSubview(self.activityIndicator)
            
            self.addSubview(self.loadingView)
            view.addSubview(self)
        }
    }
    
    
    
    public func hide() {
        DispatchQueue.main.async {
            self.appDelegate.window!.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
}
