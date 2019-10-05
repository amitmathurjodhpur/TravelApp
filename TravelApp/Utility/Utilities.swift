//
//  Utilities.swift
//  TravelApp
//
//  Created by Amit Mathur on 10/5/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import Foundation
import UIKit

class GlobalData: NSObject {
   static let sharedInstance = GlobalData()
    public func getHeaderDict() -> [String : AnyObject] {
        let header = UserDefaults.standard.value(forKey: AppKey.AuthorizationKey)
        let headerDict: [String:String] = ["Auth_token":header as? String ?? ""]
        return headerDict as [String : AnyObject]
    }
}
